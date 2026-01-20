# frozen_string_literal: true

require 'uri'

def curl(args, dest)
  sh "curl -fsSL '#{args}' > #{dest}"
end

task :init do
  sh 'pnpm i'
  sh 'bundle install'
end

directory 'tmp'

{ text: 'Noto Sans', code: 'Roboto Mono' }.each do |kind, family|
  file "tmp/#{kind}.css" => 'tmp' do |t|
    query = URI.encode_www_form(
      family: family,
      text: (' '..'~').to_a.join
    )

    curl "https://fonts.googleapis.com/css?#{query}", t.name
  end
end

rule '-font.css' => '.css' do |t|
  File.write(t.name, File.read(t.source)
    .sub(/font-family:[^;]*;/,
         "font-family: #{t.source.pathmap('%n').capitalize}Font;
          font-display: swap;")
    .sub(/url\([^)]*\)/, t.source.pathmap('url("%n.woff2")'))
    .sub(/format\([^)]*\)/, 'format("woff2")'))
end

rule '.ttf' => '.css' do |t|
  curl(/url\(([^)]+)\)/.match(File.read(t.source))[1], t.name)
end

rule %r{tmp/.*\.woff2} => ->(f) { f.pathmap('tmp/%n.ttf') } do |t|
  sh "pnpm ttf2woff2 < #{t.source} > #{t.name}"
end

file 'tmp/webpack/index.js' => %w[
  tmp/text-font.css
  tmp/code-font.css
  tmp/text.woff2
  tmp/code.woff2
] do
  sh 'pnpm webpack-cli'
end

file 'tmp/webpack/main.css' => 'tmp/webpack/index.js'

file '_includes/index.css' => 'tmp/webpack/main.css' do |t|
  cp t.source.ext('.css'), t.name
end

file '_includes/icon.svg' do |t|
  curl 'https://github.com/cloe-lang/icon/raw/master/icon.svg', t.name
end

file '_includes/x.svg' do |t|
  curl(
    'https://github.com/simple-icons/simple-icons/raw/master/icons/x.svg',
    t.name
  )
end

directory 'tmp/cloe' do |t|
  sh "git clone https://github.com/cloe-lang/cloe #{t.name}"
end

directory 'examples' => 'tmp/cloe' do |t|
  sh "go run github.com/raviqqe/gherkin2markdown #{File.join t.source, 'examples'} #{t.name}"
  File.write(File.join(t.name, 'index.md'),
             "# Examples\n\n" \
             'Code examples which describes usage of the language features ' \
             'and built-in functions and modules.')
end

directory '_site' => %w[
  _includes/index.css
  _includes/icon.svg
  _includes/x.svg
  examples
] do
  sh 'bundle exec jekyll build'
end

file '_site/index.js' => 'tmp/webpack/index.js' do |t|
  cp t.source, t.name
end

file '_site/icon.svg' => '_includes/icon.svg' do |t|
  cp t.source, t.name
end

task build: %w[_site _site/index.js _site/icon.svg] do
  sh "pnpm tsx bin/modify-html.ts #{Dir.glob('_site/**/*.html').join ' '}"
  sh 'pnpm workbox generateSW workbox-cli-config.cjs'
  cp Dir.glob('tmp/webpack/*.woff2'), '_site'
end

task :deploy do
  sh 'pnpm firebase deploy'
end

task default: %w[build deploy]

task run: :build do
  sh 'pnpm superstatic --debug'
end

task :lint do
  sh 'rubocop'
  sh 'pnpm stylelint **/*.scss'
end

task :clean do
  sh %w[git clean -dfx --exclude node_modules].join ' '
end

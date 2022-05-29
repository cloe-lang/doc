require "uri"

def curl(args, dest)
  sh "curl -sSL '#{args}' > #{dest}"
end

directory "tmp/rouge" => "tmp" do |t|
  sh %W[git clone -b v2.2.1 --single-branch
        https://github.com/jneen/rouge #{t.name}].join " "
end

task init: "tmp/rouge" do
  cp "rouge/lexer.rb", "tmp/rouge/lib/rouge/lexers/cloe.rb"

  sh "npm install"
  sh "bundle install"

  sh "go install github.com/raviqqe/gherkin2markdown"
end

directory "tmp"

{ text: "Noto Sans", code: "Roboto Mono" }.each do |kind, family|
  file "tmp/#{kind}.css" => "tmp" do |t|
    query = URI.encode_www_form(
      family: family,
      text: (" ".."~").to_a.join,
    )

    curl "https://fonts.googleapis.com/css?#{query}", t.name
  end
end

rule "-font.css" => ".css" do |t|
  File.write(t.name, File.read(t.source)
    .sub(/font-family:[^;]*;/,
         "font-family: #{t.source.pathmap("%n").capitalize}Font;
          font-display: swap;")
    .sub(/url\([^)]*\)/, t.source.pathmap('url("/%n.woff2")'))
    .sub(/format\([^)]*\)/, 'format("woff2")'))
end

rule ".ttf" => ".css" do |t|
  curl(/url\(([^)]+)\)/.match(File.read(t.source))[1], t.name)
end

rule %r{_site/.*\.woff2} => ->(f) { f.pathmap("tmp/%n.ttf") } do |t|
  tmp_filename = t.name.pathmap "tmp/%f"

  sh "cat #{t.source} | npx ttf2woff2 > #{tmp_filename}"
  sh "npx fontmin #{tmp_filename} > #{t.name}"
end

file "tmp/rouge.css" => "tmp" do |t|
  sh "bundle exec rougify style base16.solarized.dark > #{t.name}"
end

file "tmp/index.js" => %w[tmp/rouge.css tmp/text-font.css tmp/code-font.css] do
  sh "npx webpack-cli"
end

file "_includes/index.css" => "tmp/index.js" do |t|
  cp t.source.ext(".css"), t.name
end

file "tmp/icon.svg" => "tmp" do |t|
  curl "https://github.com/cloe-lang/icon/raw/master/icon.svg", t.name
end

file "_includes/icon.svg" => "tmp/icon.svg" do |t|
  cp t.source, t.name
end

file "_includes/twitter.svg" do |t|
  curl(
    "https://github.com/simple-icons/simple-icons/raw/master/icons/twitter.svg",
    t.name
  )
end

directory "tmp/cloe" do |t|
  sh "git clone https://github.com/cloe-lang/cloe #{t.name}"
end

directory "examples" => "tmp/cloe" do |t|
  sh "gherkin2markdown #{File.join t.source, "examples"} #{t.name}"
  File.write(File.join(t.name, "index.md"),
             "# Examples\n\n" \
             "Code examples which describes usage of the language features " \
             "and built-in functions and modules.")
end

directory "_site" => %w[
            _includes/index.css
            _includes/icon.svg
            _includes/twitter.svg
            examples
          ] do
  sh "bundle exec jekyll build"
end

file "_site/index.js" => "tmp/index.js" do |t|
  cp t.source, t.name
end

rule %r{tmp/icon[0-9]+\.png} => "tmp/icon.svg" do |t|
  sh %W[inkscape -w #{t.name.match(/[0-9]+/)[0]}
        --export-png #{t.name} #{t.source}].join " "
end

rule %r{_site/icon[0-9]+\.png} => [->(f) { f.pathmap("tmp/%f") }, "_site"] do |t|
  sh "npx imagemin #{t.source} > #{t.name}"
end

task build: %w[
       clean
       _site
       _site/index.js
       _site/icon512.png
       _site/icon192.png
       _site/icon16.png
       _site/text.woff2
       _site/code.woff2
     ] do
  sh "npx ts-node bin/modify-html.ts #{Dir.glob("_site/**/*.html").join " "}"
  sh "npx workbox generateSW workbox-cli-config.js"
end

task :deploy do
  sh "npx firebase deploy"
end

task default: %w[build deploy]

task run: :build do
  sh "npx superstatic --debug"
end

task :lint do
  sh "rufo -c *.rb rouge/*.rb"
  sh "npx stylelint **/*.scss"
end

task :clean do
  sh %w[git clean -dfx --exclude node_modules].join " "
end

DOMAIN = 'cloe-lang.org'.freeze
GOOGLE_SITE_VERIFICATION = 'g7AjxjmCy2QG8Pi80zkshhVd0Tt2HPPBtrTea9egYow'.freeze
ADDRESSES = ['151.101.1.195', '151.101.65.195'].freeze
S3_OPTIONS = '--acl public-read --cache-control max-age=604800,public'.freeze

def curl(args, dest)
  sh "curl -sSL '#{args}' > #{dest}"
end

directory 'tmp/rouge' => 'tmp' do |t|
  sh %W[git clone -b v2.2.1 --single-branch
        https://github.com/jneen/rouge #{t.name}].join ' '
end

task init: 'tmp/rouge' do
  cp 'rouge/lexer.rb', 'tmp/rouge/lib/rouge/lexers/cloe.rb'

  sh 'npm install'
  sh 'bundler install'
end

directory 'tmp'

[['text', 'Noto Sans'], ['code', 'Roboto Mono']].each do |args|
  file "tmp/#{args[0]}.css" => 'tmp' do |t|
    query = URI.encode_www_form(
      family: args[1],
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
    .sub(/url\([^)]*\)/, t.source.pathmap('url("/%n.woff")'))
    .sub(/format\([^)]*\)/, 'format("woff")'))
end

rule '.ttf' => '.css' do |t|
  curl(/url\(([^)]+)\)/.match(File.read(t.source))[1], t.name)
end

rule %r{_site/.*\.woff} => ->(f) { f.pathmap('tmp/%n.ttf') } do |t|
  sh "npx ttf2woff #{t.source} #{t.name}"
  sh "npx fontmin #{t.name}"
end

file 'tmp/rouge.css' => 'tmp' do |t|
  sh "bundler exec rougify style base16.solarized.dark > #{t.name}"
end

file 'tmp/index.js' => %w[tmp/rouge.css tmp/text-font.css tmp/code-font.css] do
  sh 'npx webpack-cli'
end

file '_includes/index.css' => 'tmp/index.js' do |t|
  cp t.source.ext('.css'), t.name
end

directory '_site' => '_includes/index.css' do
  sh 'bundler exec jekyll build'
end

file 'tmp/icon.svg' => 'tmp' do |t|
  curl 'https://github.com/cloe-lang/icon/raw/master/icon.svg', t.name
end

file '_site/index.js' => 'tmp/index.js' do |t|
  cp t.source, t.name
end

rule %r{tmp/icon[0-9]+\.png} => 'tmp/icon.svg' do |t|
  sh %W[inkscape -w #{t.name.match(/[0-9]+/)[0]}
        --export-png #{t.name} #{t.source}].join ' '
end

rule %r{_site/icon[0-9]+\.png} => \
     [->(f) { f.pathmap('tmp/%f') }, '_site'] do |t|
  sh "npx imagemin #{t.source} > #{t.name}"
end

task build: %w[
  clean
  _site
  _site/index.js
  _site/icon512.png
  _site/icon16.png
  _site/text.woff
  _site/code.woff
] do
  sh "npx ts-node bin/modify-html.ts #{Dir.glob('_site/**/*.html').join ' '}"
  sh 'npx workbox generateSW workbox-cli-config.js'
end

task :deploy do
  sh 'npx firebase deploy'

  sh 'terraform init'
  sh %W[terraform apply -auto-approve
        -var domain=#{DOMAIN}
        -var google_site_verification=#{GOOGLE_SITE_VERIFICATION}
        -var addresses='#{ADDRESSES}'].join ' '

  name_servers = `terraform output name_servers`
                 .split(/[,\s]+/)
                 .map { |s| 'Name=' + s }
                 .join ' '

  sh %W[
    aws route53domains update-domain-nameservers
    --domain #{DOMAIN}
    --nameservers #{name_servers}
  ].join ' '
end

task default: %w[build deploy]

task run: :build do
  sh 'npx superstatic'
end

task :lint do
  sh 'npx tslint --project .'
  sh 'npx stylelint **/*.scss'
end

task :clean do
  sh %w[git clean -dfx
        --exclude .terraform
        --exclude terraform.tfstate
        --exclude node_modules].join ' '
end

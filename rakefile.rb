DOMAIN = 'coel-lang.org'.freeze
GOOGLE_SITE_VERIFICATION = 'eFao5crNXIs5MJ2iog201ZOcvjmy7SY18yOt9aEQ-e0'.freeze
ADDRESSES = ['151.101.1.195', '151.101.65.195'].freeze
S3_OPTIONS = '--acl public-read --cache-control max-age=604800,public'.freeze

def curl(args, dest)
  sh "curl -sSL #{args} > #{dest}"
end

def git_clone(url, dest, tag: nil)
  sh %W[git clone #{!tag.nil? ? '-b ' + tag : ''} --single-branch --depth 1
        #{url} #{dest}].join ' '
end

directory 'tmp/rouge' => 'tmp' do |t|
  git_clone 'https://github.com/jneen/rouge', t.name, tag: 'v2.2.1'
end

task init: 'tmp/rouge' do
  cp 'rouge/coel.rb', 'tmp/rouge/lib/rouge/lexers'

  sh 'npm install'
  sh 'bundler install'
end

directory 'tmp'

file 'tmp/original-font.css' => 'tmp' do |t|
  curl 'https://fonts.googleapis.com/css?family=Noto+Sans', t.name
end

file 'tmp/font.css' => 'tmp/original-font.css' do |t|
  File.write(t.name,
             File.read(t.source).sub(/url\([^)]*\)/, 'url(/font.woff)')
                                .sub(/format\([^)]*\)/, 'format("woff")'))
end

file 'tmp/rouge.css' => 'tmp' do |t|
  sh "bundler exec rougify style base16.solarized.dark > #{t.name}"
end

file 'dist/index.js' => %w[tmp/rouge.css tmp/font.css] do
  sh 'npx webpack-cli'
end

file '_includes/index.css' => 'dist/index.js' do |t|
  cp File.join(File.dirname(t.source), File.basename(t.name)), t.name
end

directory '_site' => %w[_includes/index.css] do
  sh 'bundler exec jekyll build'
end

file 'tmp/icon.svg' => 'tmp' do |t|
  curl 'https://github.com/coel-lang/icon/raw/master/icon.svg', t.name
end

file '_site/index.js' => 'dist/index.js' do |t|
  cp t.source, t.name
end

file 'tmp/icon.png' => 'tmp/icon.svg' do |t|
  sh "inkscape -w 512 --export-png #{t.name} #{t.source}"
end

file 'tmp/favicon.png' => 'tmp/icon.svg' do |t|
  sh "inkscape -w 16 --export-png #{t.name} #{t.source}"
end

file '_site/icon.png' => %w[_site tmp/favicon.png tmp/icon.png] do |t|
  sh "npx imagemin #{t.sources[1..2].join ' '} --out-dir #{t.source}"
end

file '_site/favicon.png' => '_site/icon.png'

file 'tmp/font.ttf' => 'tmp/original-font.css' do |t|
  curl(/url\(([^)]+)\)/.match(File.read(t.source))[1], t.name)
end

file '_site/font.woff' => 'tmp/font.ttf' do |t|
  sh "npx ttf2woff #{t.source} #{t.name}"
  sh "npx fontmin #{t.name}"
end

task build: %w[
  clean
  _site
  _site/index.js
  _site/icon.png
  _site/favicon.png
  _site/font.woff
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

task :format do
  sh 'npx standard --fix'
end

task :clean do
  sh %w[git clean -dfx
        --exclude .terraform
        --exclude terraform.tfstate
        --exclude node_modules].join ' '
end

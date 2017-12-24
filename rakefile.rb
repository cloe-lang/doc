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
  cp 'rouge/coel.rb', 'tmp/rouge/lib/rouge/lexers'
end

task initialize: 'tmp/rouge' do
  sh 'npm install'
  sh 'bundler install'
end

directory 'tmp'

file 'tmp/noto-sans.css' => 'tmp' do |t|
  curl 'https://fonts.googleapis.com/css?family=Noto+Sans', t.name
end

file 'tmp/rouge.css' => 'tmp' do |t|
  sh "bundler exec rougify style base16.solarized.dark > #{t.name}"
end

file 'tmp/index.js' => %w[tmp/noto-sans.css tmp/rouge.css] do
  sh 'npx webpack'
end

file '_includes/index.css' => 'tmp/index.js'

directory '_site' => %w[_includes/index.css] do
  sh 'bundler exec jekyll build'
end

file 'tmp/icon.svg' => 'tmp' do |t|
  curl 'https://github.com/coel-lang/icon/raw/master/icon.svg', t.name
end

file '_site/index.js' => 'tmp/index.js' do |t|
  cp t.source, t.name
end

file '_site/icon.png' => %w[tmp/icon.svg _site] do |t|
  sh "inkscape -w 192 --export-png #{t.name} #{t.source}"
end

file '_site/favicon.png' => '_site/icon.png' do |t|
  sh "convert -resize 16x16 #{t.source} #{t.name}"
end

task build: %w[
  clean
  _site
  _site/index.js
  _site/icon.png
  _site/favicon.png
] do
  sh "npx ts-node bin/modify-html.ts #{Dir.glob('_site/**/*.html').join ' '}"
  sh 'npx workbox generate:sw'
end

task :deploy do
  sh 'firebase deploy'

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
  cd '_site' do
    sh 'python3 -m http.server 8888'
  end
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

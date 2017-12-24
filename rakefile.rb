DOMAIN = 'coel-lang.org'.freeze
S3_OPTIONS = '--acl public-read --cache-control max-age=604800,public'.freeze

def curl(args, dest)
  sh "curl -sSL #{args} > #{dest}"
end

task :initialize do
  sh 'npm install'
  sh 'bundler install'
end

directory 'tmp'

file 'tmp/noto-sans.css' => 'tmp' do |t|
  curl 'https://fonts.googleapis.com/css?family=Noto+Sans', t.name
end

file 'index.js' => 'tmp/noto-sans.css' do
  sh 'npx webpack'
end

file '_includes/index.css' => 'index.js'

directory '_site' => %w[index.js _includes/index.css] do
  sh 'jekyll build'
end

file 'tmp/icon.svg' => 'tmp' do |t|
  curl 'https://github.com/coel-lang/icon/raw/master/icon.svg', t.name
end

file '_site/icon.png' => %w[tmp/icon.svg _site] do |t|
  sh "inkscape -w 192 --export-png #{t.name} #{t.source}"
end

file '_site/favicon.png' => '_site/icon.png' do |t|
  sh "convert -resize 16x16 #{t.source} #{t.name}"
end

file '_site/service-worker.js' => '_site' do
  sh 'npx workbox generate:sw'
end

task build: %w[
  clean
  _site
  _site/icon.png
  _site/favicon.png
  _site/service-worker.js
]

task default: :build do
  sh 'terraform init'
  sh "terraform apply -auto-approve -var domain=#{DOMAIN}"

  bucket = `terraform output bucket`.strip

  sh "aws s3 sync #{S3_OPTIONS} --delete _site s3://#{bucket}"

  Dir.glob('_site/**/*.html').each do |path|
    next if File.basename(path) == 'index.html'

    sh %W[aws s3 cp #{S3_OPTIONS} --content-type text/html
          #{path}
          s3://#{bucket}#{path[5..-1].ext}].join ' '
  end

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

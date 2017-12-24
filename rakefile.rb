require 'xml-dsl'

DOMAIN = 'coel-lang.org'.freeze
S3_OPTIONS = '--acl public-read --cache-control max-age=604800,public'.freeze

def curl(args, dest)
  sh "curl -sSL #{args} > #{dest}"
end

task :initialize do
  sh 'npm install'
  sh 'bundler install'
end

task scripts: :clean do
  mkdir_p 'tmp'

  cd 'tmp' do
    curl 'https://fonts.googleapis.com/css?family=Noto+Sans', 'noto-sans.css'
  end

  sh 'npx webpack'

  sh 'jekyll build'

  cd 'tmp' do
    curl 'https://github.com/coel-lang/icon/raw/master/icon.svg', 'icon.svg'
    sh 'inkscape -w 192 --export-png ../_site/icon.png icon.svg'
  end

  sh 'npx workbox generate:sw'
end

file 'favicon.png' do |_t|
  sh 'wget https://raw.githubusercontent.com/coel-lang/icon/master/icon.png'
  sh 'convert -resize 16x16 icon.png favicon.png'
end

task build: %w[favicon.png scripts]

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

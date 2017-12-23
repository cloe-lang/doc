require 'xml-dsl'

DOMAIN = 'coel-lang.org'.freeze
S3_OPTIONS = '--acl public-read --cache-control max-age=604800,public'.freeze

task scripts: :clean do
  mkdir_p 'tmp'

  cd 'tmp' do
    sh 'curl https://fonts.googleapis.com/css?family=Noto+Sans > noto-sans.css'
  end

  sh 'npm install'
  sh 'npx webpack'

  sh 'jekyll build'

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

task :lint do
  sh 'go get -u github.com/raviqqe/liche'
  sh "liche -v #{Dir.glob('**/*.md').join ' '}"
end

task :format do
  sh 'npm install'
  sh 'npx standard --fix'
end

task :clean do
  sh %w[git clean -dfx
        --exclude .terraform
        --exclude terraform.tfstate
        --exclude node_modules].join ' '
end

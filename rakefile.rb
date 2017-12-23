require 'xml-dsl'

DOMAIN = 'coel-lang.org'.freeze
HIGHLIGHT_CSS_URL = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js'\
                    '/9.12.0/styles/solarized-dark.min.css'.freeze
HIGHLIGHT_JS_URL = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/'\
                   '9.12.0/highlight.min.js'.freeze
JQUERY_URL = 'https://code.jquery.com/jquery-3.2.1.min.js'.freeze
TTL = 604_800
S3_OPTIONS = "--acl public-read --cache-control max-age=#{TTL},public".freeze

task scripts: :clean do
  sh 'jekyll build'

  cd '_site' do
    sh "curl #{HIGHLIGHT_CSS_URL} > highlight.css"
    sh "curl #{HIGHLIGHT_JS_URL} > highlight.js"
    sh "curl #{JQUERY_URL} > jquery.js"
  end

  sh 'npm install'
  sh 'npx workbox generate:sw'

  sh 'npx webpack'
end

file 'favicon.png' do |_t|
  sh 'wget https://raw.githubusercontent.com/coel-lang/icon/master/icon.png'
  sh 'convert -resize 16x16 icon.png favicon.png'
end

task build: %w[favicon.png scripts]

task default: :build do
  sh 'terraform init'
  sh "terraform apply -auto-approve -var domain=#{DOMAIN} -var ttl=#{TTL}"

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
  sh 'git clean -dfx --exclude .terraform --exclude terraform.tfstate'
end

# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telein/version'

Gem::Specification.new do |gem|
  gem.name          = "telein-client"
  gem.version       = Telein::VERSION
  gem.summary       = %q{Client to access Telein API in Ruby}
  gem.description   = %q{The 'telein-client' gem allows the access for
the Telein API in Ruby.}
  gem.license       = "MIT"
  gem.authors       = ["Thiago Brandão Damasceno"]
  gem.email         = "thiagobrandam@gmail.com"
  gem.homepage      = "https://github.com/thiagobrandam/telein-client#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'curb', '~> 0.8'

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'redcarpet'
  gem.add_development_dependency 'rspec', '~> 2.13.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'webmock', '~> 1.11'
  gem.add_development_dependency 'yard', '~> 0.8'
end

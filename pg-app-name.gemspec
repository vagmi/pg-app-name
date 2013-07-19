# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pg-app-name/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vagmi Mudumbai"]
  gem.email         = ["vagmi.mudumbai@gmail.com"]
  gem.description   = %q{Sets the application name for a postgres connection}
  gem.summary       = %q{Sets the application name for a postgres connection}
  gem.homepage      = "https://github.com/vagmi/pg-app-name"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "pg-app-name"
  gem.require_paths = ["lib"]
  gem.version       = Pg::App::Name::VERSION
  gem.add_dependency 'activerecord', '~> 4'
  gem.add_dependency 'pg', '~> 0'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 2'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'etcdist/version'

Gem::Specification.new do |spec|
  spec.name          = 'etcdist'
  spec.version       = Etcdist::VERSION
  spec.authors       = ['Springer, Part of Springer Science+Business Media']
  spec.summary       = 'Populate etcd in a reproducable way.  '
  spec.homepage      = 'https://github.com/springersbm/etcdist'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0'

  spec.add_runtime_dependency 'etcd', '~> 0.2.4'
  spec.add_runtime_dependency 'mixlib-log'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-mocks', '~> 3.0'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rubocop'
end

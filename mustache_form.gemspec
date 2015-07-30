# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mustache_form/version'

Gem::Specification.new do |spec|
  spec.name          = "mustache_form"
  spec.version       = MustacheForm::VERSION
  spec.authors       = ["Steve Forkin"]
  spec.email         = ["steve.forkin@gmail.com"]

  spec.summary       = %q{small library to handle integrated mustache and rails form helpers}
  spec.description   = %q{Also support for simple_form gem included}
  spec.homepage      = "http://github.com/netflakes/mustache_form"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Development dependencies
  #
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "coveralls"
  #
  # - gem related ones
  spec.add_development_dependency 'mustache'
  spec.add_development_dependency 'simple_form'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-given'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'rspec-rails'
  #
  # Runtime dependencies
  #
  spec.add_runtime_dependency 'rails', '>= 4.1.1'
end

# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gdbcompiler/version'

Gem::Specification.new do |spec|
  spec.name          = 'gdbcompiler'
  spec.version       = Gdbcompiler::VERSION
  spec.authors       = ['Tanapat Sainak']
  spec.email         = ['fallen_things@hotmail.com']

  spec.summary       = 'Self lib nothing to summarize here'
  spec.description   = 'Self lib nothing to describe here'
  spec.homepage      = 'https://github.com/gastzars/gdbcompiler'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard', '~> 2.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.3'
end

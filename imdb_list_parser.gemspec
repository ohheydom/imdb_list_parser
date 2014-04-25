# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imdb_list_parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'imdb_list_parser'
  spec.version       = ImdbListParser::VERSION
  spec.authors       = ['Dom Leone']
  spec.email         = ['ohheydom@gmail.com']
  spec.description   = ImdbListParser::DESCRIPTION 
  spec.summary       = ImdbListParser::DESCRIPTION
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'nokogiri', '~> 1.6.1'
  spec.add_development_dependency 'vcr', '~> 2.9.0'
  spec.add_development_dependency 'webmock', '~> 1.17.4'
end

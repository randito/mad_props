# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mad_props/version'

Gem::Specification.new do |spec|
  spec.name          = "mad_props"
  spec.version       = MadProps::VERSION
  spec.authors       = ["Randy Pond"]
  spec.email         = ["randito@gmail.com"]
  spec.description   = %q{Property Lists with inheritance and caching.  Oh my!}
  spec.summary       = %q{Property lists that support inheritance, caching, and storage.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

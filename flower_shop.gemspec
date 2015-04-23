# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flower_shop/version'

Gem::Specification.new do |spec|
  spec.name          = "flower_shop"
  spec.version       = FlowerShop::VERSION
  spec.authors       = ["Marc Lee"]
  spec.email         = ["marc@adviso.com.au"]
  spec.description   = %q{Flower Shop Test}
  spec.summary       = %q{Flower Shop test. }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'highline'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "ZenTest"
  spec.add_development_dependency "shoulda"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "awesome_print"

end


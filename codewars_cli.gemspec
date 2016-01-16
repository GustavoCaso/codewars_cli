# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codewars_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "codewars_cli"
  spec.version       = CodewarsCli::VERSION
  spec.authors       = ["GustavoCaso"]
  spec.email         = ["gustavocaso@gmail.com"]

  spec.summary       = %q{CLI tool to interact with codewars in the comfort of your terminal}
  spec.description   = %q{CLI tool to interact with codewars in the comfort of your terminal,
                          allow you to fetch users information, kata, upload solutions and close it.
                         }
  spec.homepage      = "https://github.com/GustavoCaso/codewars_cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency "codewars_client"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "pry"
  spec.add_development_dependency 'webmock'
end

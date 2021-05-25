# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "onceover-gatekeeper"
  spec.version       = '0.0.1'
  spec.authors       = ["Dylan Ratcliffe"]
  spec.email         = ["dylan.ratcliffe@puppet.com"]

  spec.summary       = "Adds gatekeeper functionality to onceover"
  spec.description   = ""
  spec.homepage      = "https://github.com/dylanratcliffe/onceover-gatekeeper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake", ">= 12.3.3" 
  spec.add_runtime_dependency 'onceover', '>= 3.2.0'
end

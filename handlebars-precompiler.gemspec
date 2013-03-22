# -*- encoding: utf-8 -*-
require File.expand_path('../lib/handlebars_precompiler/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Felipe Elias Philipp"]
  gem.email         = ["felipeelias@gmail.com"]
  gem.description   = "Precompile handlebars templates"
  gem.summary       = "Precompile handlebars templates"
  gem.homepage      = "https://github.com/felipeelias/handlebars-precompiler"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "handlebars_precompiler"
  gem.require_paths = ["lib"]
  gem.version       = HandlebarsPrecompiler::VERSION

  gem.add_development_dependency 'rspec'
end

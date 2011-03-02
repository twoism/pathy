# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pathy/version"

Gem::Specification.new do |s|
  s.name        = "pathy"
  s.version     = Pathy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christopher Burnett"]
  s.email       = ["signalstatic@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/pathy"
  s.summary     = %q{JSON Validation Helper}
  s.description = %q{Simple JSON Validation and rspec matchers}

  s.rubyforge_project = "pathy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

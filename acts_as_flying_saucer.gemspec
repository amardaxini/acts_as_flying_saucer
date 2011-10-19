# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_flying_saucer/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_flying_saucer"
  s.version     = ActsAsFlyingSaucer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Amar Daxini"]
  s.email       = ["amardaxini@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/acts_as_flying_saucer"
  s.summary     = %q{XHTML to PDF using Flying Saucer java library}
  s.description = %q{XHTML to PDF using Flying Saucer java library}
	s.add_dependency "nailgun"
  s.add_dependency "tidy_ffi"
  s.rubyforge_project = "acts_as_flying_saucer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

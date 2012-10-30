#-*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
    s.name        = "redenv"
    s.version     = "0.0.1"
    s.authors     = ["Lou Kamenov"]
    s.email       = ["lkv@rypple.com"]
    s.homepage    = ""
    s.summary     = %q{Similar to daemontools envdir, using redis for k/v env pairs}
    s.description = %q{Similar to daemontools envdir, using redis for k/v env pairs}

    s.rubyforge_project = "redenv"

    s.files         = `git ls-files`.split("\n")
    s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
    s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    s.require_paths = ["lib"]

    # specify any dependencies here; for example:
    s.add_development_dependency "rspec"
    s.add_dependency "redis"
end

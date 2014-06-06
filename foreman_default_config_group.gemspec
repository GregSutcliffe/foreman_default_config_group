$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "foreman_default_config_group/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name             = %q{foreman_default_config_group}
  s.version          = ForemanDefaultConfigGroup::VERSION
  s.authors          = ["Greg Sutcliffe"]
  s.email            = %q{gsutclif@redhat.com}
  s.description      = %q{Adds the option to specify a default config_group for new hosts created from facts/reports}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files            = Dir["{app,extra,config,db,lib}/**/*"] + ["LICENSE", "README.md"]
  s.test_files       = Dir["test/**/*"]
  s.homepage         = %q{http://github.com/GregSutcliffe/foreman_default_config_group}
  s.licenses         = ["GPL-3"]
  s.summary          = %q{Default Config Group Plugin for Foreman}
end

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "mux/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "mux-rails"
  spec.version     = Mux::Rails::VERSION
  spec.authors     = ["Asger Behncke Jacobsen"]
  spec.email       = ["a@asgerbehnckejacobsen.dk"]
  spec.homepage    = "https://www.github.com/asgerb/mux-rails"
  spec.summary     = "A Rails Engine for integrating with Mux."
  spec.description = "A Rails Engine for integrating with Mux."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.0"
  spec.add_dependency "mux_ruby", "~> 1.8.0"

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-rails"
  spec.add_development_dependency "sqlite3"
end

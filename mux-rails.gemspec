# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "mux/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "mux-rails"
  spec.version     = Mux::Rails::VERSION
  spec.authors     = [ "Asger Behncke Jacobsen", "Tomáš Celizna" ]
  spec.email       = [ "a@asgerbehnckejacobsen.dk", "mail@tomascelizna.com" ]
  spec.homepage    = "https://www.github.com/asgerb/mux-rails"
  spec.summary     = "A Rails Engine for integrating with Mux."
  spec.description = "A Rails Engine for integrating with Mux."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 7.0"
  spec.add_dependency "dry-struct", "~> 1.4"
  spec.add_dependency "dry-types", "~> 1.5"
  spec.add_dependency "mux_ruby", "~> 5.0"

  spec.add_development_dependency "minitest", "~> 5.25"
  spec.add_development_dependency "minitest-rails"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rubocop-rails-omakase"
end

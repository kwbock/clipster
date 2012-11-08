$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "clipster/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "clipster"
  s.version     = Clipster::VERSION
  s.authors     = ["Kyle Bock", "Daniel White"]
  s.email       = ["kylewbock@gmail.com"]
  s.homepage    = "http://github.com/kwbock/clipster"
  s.summary     = "Provides sharable clipboard functionality via an engine to an existing rails app."
  s.description = "Code clips before they were cool. See README for deployment information"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "coderay"
  s.add_dependency "dynamic_form"
  s.add_dependency "jquery-rails"
  s.add_dependency "whenever"
  s.add_dependency "kaminari"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end

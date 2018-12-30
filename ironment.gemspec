require File.join(File.dirname(__FILE__), "lib", "ironment", "version")

Gem::Specification.new do |s|
  s.name        = "ironment"
  s.version     = Ironment::VERSION
  s.license     = "MIT"

  s.summary     = "Environment populator & command wrapper utility."
  s.description = "Ironment populates environment variables with runcoms and executes commands."

  s.authors     = ["Jonas Amundsen"]
  s.email       = ["jonasba+gem@gmail.com"]
  s.homepage    = "https://github.com/badeball/ironment"

  s.executable  = "iron"
  s.files       = Dir["LICENSE", "README.md", "lib/**/*"]
  s.test_files  = Dir["test/**/*.rb"]

  s.add_dependency("commander", ">= 4.3.5")

  s.add_development_dependency("fakefs", "0.6.7")
  s.add_development_dependency("guard", "2.13.0")
  s.add_development_dependency("guard-minitest", "2.4.4")
  s.add_development_dependency("minitest", "5.5.1")
  s.add_development_dependency("rake", "10.4.2")
end

require File.join(File.dirname(__FILE__), "lib", "ironment", "version")

Gem::Specification.new do |s|
  s.name        = "ironment"
  s.version     = Ironment::VERSION
  s.license     = "MIT"
  s.date        = "2015-04-27"

  s.summary     = "Automatic environment variable container."
  s.description = "Ironment populates environment variables with runcoms and executes commands."

  s.authors     = ["Jonas Amundsen"]
  s.email       = ["jonasba+gem@gmail.com"]
  s.homepage    = "https://github.com/badeball/ironment"

  s.executables = "iron"

  s.files       = %w[
    .travis.yml
    Gemfile
    Gemfile.lock
    LICENSE
    README.md
    Rakefile
    bin/iron
    ironment.gemspec
    lib/ironment.rb
    lib/ironment/executor.rb
    lib/ironment/finder.rb
    lib/ironment/populator.rb
    lib/ironment/version.rb
    test/finder_test.rb
    test/ironment_test.rb
    test/populator_test.rb
  ]

  s.add_development_dependency("fakefs")
  s.add_development_dependency("minitest")
  s.add_development_dependency("rake")
end

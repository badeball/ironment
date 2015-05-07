require File.join(File.dirname(__FILE__), "lib", "ironment", "version")

Gem::Specification.new do |s|
  s.name        = "ironment"
  s.version     = Ironment::VERSION
  s.license     = "MIT"
  s.date        = "2015-05-04"

  s.summary     = "Environment populator & command wrapper utility."
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
    lib/ironment/pair_reader.rb
    lib/ironment/populator.rb
    lib/ironment/runcom.rb
    lib/ironment/version.rb
    test/finder_test.rb
    test/ironment_test.rb
    test/pair_reader_test.rb
    test/populator_test.rb
    test/runcom_test.rb
    test/test_helper.rb
  ]

  s.add_development_dependency("codeclimate-test-reporter", "0.4.7")
  s.add_development_dependency("fakefs", "0.6.7")
  s.add_development_dependency("minitest", "5.5.1")
  s.add_development_dependency("rake", "10.4.2")
end

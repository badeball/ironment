require "minitest/autorun"
require "ironment"

describe Ironment do
  describe "#exec_with_environment" do
    it "find all runcoms, populate with their data and exec the command" do
      finder = Minitest::Mock.new
      finder.expect :find, ["/foo/.ironment"].to_enum

      populator = Minitest::Mock.new
      populator.expect :populate_with, true, ["/foo/.ironment"]

      executor = Minitest::Mock.new
      executor.expect :exec, true, ["some-command"]

      Ironment.new({
        finder: finder,
        populator: populator,
        executor: executor
      }).exec_with_environment "some-command"

      [finder, populator, executor].each &:verify
    end
  end
end

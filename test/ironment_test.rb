require "test_helper"

describe Ironment do
  describe "#exec_with_environment" do
    it "find all runcoms, verify them, populate with their data and exec the command" do
      runcom = Ironment::Runcom.new("/foo/.ironment")

      finder = Minitest::Mock.new
      finder.expect :find, [runcom].to_enum

      truster = Minitest::Mock.new
      truster.expect :validate, true, [runcom]

      populator = Minitest::Mock.new
      populator.expect :populate_with, true, [runcom]

      executor = Minitest::Mock.new
      executor.expect :exec, true, ["some-command"]

      Ironment.new({
        truster: truster,
        finder: finder,
        populator: populator,
        executor: executor
      }).exec_with_environment "some-command"

      [finder, truster, populator, executor].each &:verify
    end
  end
end

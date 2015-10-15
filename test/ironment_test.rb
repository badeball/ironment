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

  describe "#trust" do
    it "should invoke Ironment::Truster#trust with a runcom" do
      truster = MiniTest::Mock.new
      truster.expect :trust, nil, [Ironment::Runcom.new("foo")]

      Ironment.new(truster: truster).trust "foo"

      truster.verify
    end
  end

  describe "#untrust" do
    it "should invoke Ironment::Truster#untrust with a runcom" do
      truster = MiniTest::Mock.new
      truster.expect :untrust, nil, [Ironment::Runcom.new("foo")]

      Ironment.new(truster: truster).untrust "foo"

      truster.verify
    end
  end
end

require "test_helper"

describe Ironment::Config do
  before :each do
    Ironment::Config.config_path = "/config"
    FakeFS.activate!
  end

  after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  describe "#[]" do
    describe "when the configuration key exist" do
      it "should return its value" do
        File.write "/config", "FOO=1"

        assert_equal "1", Ironment::Config.new["FOO"]
      end
    end

    describe "when the configuration key does not exist" do
      it "should return nil" do
        File.write "/config", "FOO=1"

        assert_nil Ironment::Config.new["BAR"]
      end
    end
  end

  describe "#[]=" do
    describe "when the configuration key does not exist" do
      it "should append it and its value to the end of the file" do
        File.write "/config", ""

        Ironment::Config.new["FOO"] = 1

        assert_equal "FOO=1", File.read("/config")
      end
    end

    describe "when the configuration key already exist" do
      it "should change its value" do
        File.write "/config", "FOO=1"

        Ironment::Config.new["FOO"] = 2

        assert_equal "FOO=2", File.read("/config")
      end
    end
  end
end

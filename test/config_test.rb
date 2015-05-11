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
    it "should return the configuration value if it exist" do
      File.write "/config", "FOO=1"

      assert_equal "1", Ironment::Config.new["FOO"]
    end

    it "should return nil if the configuration value doesn't exist" do
      File.write "/config", "FOO=1"

      assert_nil Ironment::Config.new["BAR"]
    end

    it "should return nil if the configuration file doesn't exist" do
      begin
        File.delete "/config"
      rescue Errno::ENOENT
        # Noop
      end

      assert_nil Ironment::Config.new["BAR"]
    end
  end

  describe "#[]=" do
    it "should write a configuration value to the file" do
      File.write "/config", ""

      Ironment::Config.new["FOO"] = 1

      assert_equal "FOO=1", File.read("/config")
    end

    it "should overwrite an existing configuration value" do
      File.write "/config", "FOO=1"

      Ironment::Config.new["FOO"] = 2

      assert_equal "FOO=2", File.read("/config")
    end

    it "should create the directory if missing" do
      Ironment::Config.config_path = "/foo/bar/config"

      Ironment::Config.new["FOO"] = 1

      assert_equal true, File.exist?("/foo/bar/config")
    end

    it "should delete the configuration value when set to nil" do
      File.write "/config", "FOO=1"

      Ironment::Config.new["FOO"] = nil

      assert_equal "", File.read("/config")
    end
  end
end

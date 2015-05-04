require "minitest/autorun"
require "fakefs/safe"
require "ironment"

describe Ironment::Populator do
  before :each do
    FakeFS.activate!
  end

  after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  it "should read a file and populate the environment with its content" do
    File.write("/foo", <<-DAT.gsub(/^\s+/, ""))
      BAR=1
      BAZ=2
    DAT

    env = Minitest::Mock.new
    env.expect :[]=, "1", ["BAR", "1"]
    env.expect :[]=, "2", ["BAZ", "2"]

    Ironment::Populator.new(
      env: env
    ).populate_with "/foo"

    env.verify
  end

  it "should ignore comment lines" do
    File.write("/foo", <<-DAT.gsub(/^\s+/, ""))
      # This is a comment
    DAT

    env = Minitest::Mock.new

    # Expect no invokations

    Ironment::Populator.new(
      env: env
    ).populate_with "/foo"

    env.verify
  end
end

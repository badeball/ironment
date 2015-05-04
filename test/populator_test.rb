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

    Ironment::Populator.new.populate_with "/foo"

    assert_equal ENV["BAR"], "1"
    assert_equal ENV["BAZ"], "2"
  end
end

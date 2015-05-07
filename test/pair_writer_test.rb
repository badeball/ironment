require "test_helper"

describe Ironment::PairWriter do
  before :each do
    FakeFS.activate!
  end

  after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  class DummyWriter < Struct.new(:file)
    include Ironment::PairWriter
  end

  describe "#write_pairs" do
    it "should write each key-value pair to a file" do
      DummyWriter.new(".envrc").write_pairs "FOO" => "bar"

      assert_equal "FOO=bar", File.read(".envrc")
    end

    it "should create the file if it is missing" do
      DummyWriter.new("/foo/bar/.envrc").write_pairs "FOO" => "bar"

      assert_equal true, File.exist?("/foo/bar/.envrc")
    end
  end
end

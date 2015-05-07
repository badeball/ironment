require "test_helper"

describe Ironment::PairReader do
  before :each do
    FakeFS.activate!
  end

  after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  class DummyReader < Struct.new(:file)
    include Ironment::PairReader
  end

  describe "#read_pairs" do
    it "should read each key-value pair from a file" do
      File.write ".envrc", <<-DAT.gsub(/^\s+/, "")
        BAR=1
        BAZ=2
      DAT

      pairs = DummyReader.new(".envrc").read_pairs

      assert_equal({"BAR" => "1", "BAZ" => "2"}, pairs)
    end

    it "should ignore comment lines" do
      File.write(".envrc", <<-DAT.gsub(/^\s+/, ""))
        # This is a comment
      DAT

      pairs = DummyReader.new(".envrc").read_pairs

      assert_equal 0, pairs.size
    end
  end
end

require "test_helper"

describe Ironment::Runcom do
  before :each do
    FakeFS.activate!
  end

  after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  describe "#sha1sum" do
    it "should return the sha1sum of the runcom" do
      File.write(".envrc", "FOO=1")

      # The sha1sum of "FOO=1"
      assert_equal "67364d1a7020017cf162d2751680b0f89f51da70", Ironment::Runcom.new(".envrc").sha1sum
    end
  end

  describe "#==" do
    it "should return true for two runcoms of same file" do
      one = Ironment::Runcom.new ".envrc"
      two = Ironment::Runcom.new ".envrc"

      assert_equal true, one == two
    end

    it "should return false for two runcoms of different file" do
      one = Ironment::Runcom.new "foo/.envrc"
      two = Ironment::Runcom.new "bar/.envrc"

      assert_equal false, one == two
    end
  end
end

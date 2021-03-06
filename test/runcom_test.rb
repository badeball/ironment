require "test_helper"

describe Ironment::Runcom do
  before :each do
    FakeFS.activate!
  end

  after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  describe "#initialize" do
    it "should expand the given path" do
      Dir.mkdir "/foo"

      Dir.chdir "/foo" do
        expanded_path = Ironment::Runcom.new(".envrc").file

        assert_equal "/foo/.envrc", expanded_path
      end
    end
  end

  describe "#sha1sum" do
    it "should return the sha1sum of the runcom" do
      File.write(".envrc", "FOO=1")

      # The sha1sum of "FOO=1"
      assert_equal "67364d1a7020017cf162d2751680b0f89f51da70", Ironment::Runcom.new(".envrc").sha1sum
    end

    it "should cache the file content on first read" do
      File.write(".envrc", "FOO=1")

      runcom = Ironment::Runcom.new(".envrc")

      runcom.sha1sum

      File.delete(".envrc")

      # The sha1sum of "FOO=1"
      assert_equal "67364d1a7020017cf162d2751680b0f89f51da70", runcom.sha1sum
    end
  end

  describe "#each_pair" do
    it "should return an enumerator for each key-value pair" do
      File.write ".envrc", <<-DAT.gsub(/^\s+/, "")
        BAR=1
        BAZ=2
      DAT

      enum = Ironment::Runcom.new(".envrc").each_pair

      assert_equal enum.next, ["BAR", "1"]
      assert_equal enum.next, ["BAZ", "2"]
    end

    it "should ignore comment lines" do
      File.write(".envrc", <<-DAT.gsub(/^\s+/, ""))
        # This is a comment
      DAT

      enum = Ironment::Runcom.new(".envrc").each_pair

      assert_equal 0, enum.count
    end

    it "should raise MalformedRuncom upon reading a malformed file" do
      File.write(".envrc", <<-DAT.gsub(/^\s+/, ""))
        FOO+1
      DAT

      assert_raises Ironment::MalformedRuncom do
        Ironment::Runcom.new(".envrc").each_pair
      end
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

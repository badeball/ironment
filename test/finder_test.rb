require "test_helper"

module FakeFS
  class Pathname
    def root?
      !!(chop_basename(@path).nil? && /#{SEPARATOR_PAT}/o =~ @path)
    end
  end
end

describe Ironment::Finder do
  before :each do
    FakeFS.activate!
    Dir.mkdir "/foo"
    Dir.mkdir "/foo/bar"
  end

  after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  it "should return the runcom in the current directory" do
    FileUtils.touch "/foo/bar/.envrc"

    Dir.chdir "/foo/bar" do
      assert_includes Ironment::Finder.new.find, Ironment::Runcom.new("/foo/bar/.envrc")
    end
  end

  it "should return the runcom somewhere in the upper directory" do
    FileUtils.touch "/foo/.envrc"

    Dir.chdir "/foo/bar" do
      assert_includes Ironment::Finder.new.find, Ironment::Runcom.new("/foo/.envrc")
    end
  end

  it "should return the runcom in the root directory" do
    FileUtils.touch "/.envrc"

    Dir.chdir "/foo/bar" do
      assert_includes Ironment::Finder.new.find, Ironment::Runcom.new("/.envrc")
    end
  end
end

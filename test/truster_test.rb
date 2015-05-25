require "test_helper"

describe Ironment::Truster do
  describe "#validate" do
    it "should raise NotTrusted if the file is untrusted" do
      config = Minitest::Mock.new
      config.expect :[], nil, [".envrc"]

      runcom = Minitest::Mock.new
      runcom.expect :file, ".envrc"

      assert_raises Ironment::Truster::NotTrusted do
        Ironment::Truster.new(config: config).validate(runcom)
      end
    end

    it "should raise Modified if the file is trusted, but modified" do
      config = Minitest::Mock.new
      config.expect :[], "da39a3ee5e6b4b0d3255bfef95601890afd80709", [".envrc"]

      runcom = Minitest::Mock.new
      runcom.expect :file, ".envrc"
      runcom.expect :sha1sum, "94b720c5eafb6205d7e0399a41d2ea78f69c653c"

      assert_raises Ironment::Truster::Modified do
        Ironment::Truster.new(config: config).validate(runcom)
      end
    end

    it "should return true if the file is trusted" do
      config = Minitest::Mock.new
      config.expect :[], "67364d1a7020017cf162d2751680b0f89f51da70", [".envrc"]

      runcom = Minitest::Mock.new
      runcom.expect :file, ".envrc"
      runcom.expect :sha1sum, "67364d1a7020017cf162d2751680b0f89f51da70"

      assert_equal true, Ironment::Truster.new(config: config).validate(runcom)
    end
  end

  describe "#trust" do
    it "should mark it and its sha1 as trusted" do
      config = Minitest::Mock.new
      config.expect :[]=, nil, [".envrc", "67364d1a7020017cf162d2751680b0f89f51da70"]

      runcom = Minitest::Mock.new
      runcom.expect :file, ".envrc"
      runcom.expect :sha1sum, "67364d1a7020017cf162d2751680b0f89f51da70"

      Ironment::Truster.new(config: config).trust(runcom)

      config.verify
    end
  end

  describe "#untrust" do
    it "should remove the trust mark of the file" do
      config = Minitest::Mock.new
      config.expect :[]=, nil, [".envrc", nil]

      runcom = Minitest::Mock.new
      runcom.expect :file, ".envrc"

      Ironment::Truster.new(config: config).untrust(runcom)

      config.verify
    end
  end
end

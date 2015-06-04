require "test_helper"
require "stringio"

def test_exception_handling(exception, method, message)
  truster = Object.new

  truster.define_singleton_method method do |*|
    raise exception
  end

  describe "upon receiving #{exception.inspect}" do
    it "should return false" do
      result = Ironment::CL.new(truster: truster, stderr: StringIO.new).send(method, ".envrc")

      assert_equal false, result
    end

    it "should write #{message.inspect} to :stderr" do
      stderr = StringIO.new

      Ironment::CL.new(truster: truster, stderr: stderr).send(method, ".envrc")

      assert_includes stderr.string, message
    end

    it ":stderr should end with a newline" do
      stderr = StringIO.new

      Ironment::CL.new(truster: truster, stderr: stderr).send(method, ".envrc")

      assert_equal "\n", stderr.string[-1]
    end
  end
end

describe Ironment::CL do
  describe "#trust" do
    describe "when succesfully trusting a file" do
      it "should return true" do
        truster = Minitest::Mock.new
        truster.expect :trust, true, [Ironment::Runcom.new(".envrc")]

        assert_equal true, Ironment::CL.new(truster: truster).trust(".envrc")
      end

      it "should not write to :stderr" do
        truster = Minitest::Mock.new
        truster.expect :trust, true, [Ironment::Runcom.new(".envrc")]

        stderr = StringIO.new

        Ironment::CL.new(truster: truster, stderr: stderr).trust(".envrc")

        assert_equal "", stderr.string
      end
    end

    test_exception_handling Errno::EACCES, :trust, "ironment: Permission denied"
    test_exception_handling Errno::ENOENT, :trust, "ironment: No such file or directory"
    test_exception_handling Errno::EISDIR, :trust, "ironment: Is a directory"
  end

  describe "#untrust" do
    describe "when succesfully untrusting a file" do
      it "should return true" do
        truster = Minitest::Mock.new
        truster.expect :untrust, true, [Ironment::Runcom.new(".envrc")]

        assert_equal true, Ironment::CL.new(truster: truster).untrust(".envrc")
      end

      it "should not write to :stderr" do
        truster = Minitest::Mock.new
        truster.expect :untrust, true, [Ironment::Runcom.new(".envrc")]

        stderr = StringIO.new

        Ironment::CL.new(truster: truster, stderr: stderr).untrust(".envrc")

        assert_equal "", stderr.string
      end
    end

    test_exception_handling Errno::EACCES, :untrust, "ironment: Permission denied"
    test_exception_handling Errno::ENOENT, :untrust, "ironment: No such file or directory"
    test_exception_handling Errno::EISDIR, :untrust, "ironment: Is a directory"
  end
end

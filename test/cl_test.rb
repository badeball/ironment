require "test_helper"
require "stringio"

def test_exception_handling(exception, message, method, *args)
  ironment = Object.new

  ironment.define_singleton_method method do |*|
    raise exception
  end

  describe "upon receiving #{exception.inspect}" do
    it "should write #{message.inspect} to :stderr" do
      err = StringIO.new

      Ironment::CL.new(ironment: ironment, err: err).send(method, *args)

      assert_includes err.string, message
    end

    it ":stderr should end with a newline" do
      err = StringIO.new

      Ironment::CL.new(ironment: ironment, err: err).send(method, *args)

      assert_equal "\n", err.string[-1]
    end
  end
end

describe Ironment::CL do
  describe "#exec_with_environment" do
    describe "when successfully execing with a command" do
      it "should not write to :stderr" do
        ironment = Minitest::Mock.new
        ironment.expect :exec_with_environment, true, ["foo"]

        err = StringIO.new

        Ironment::CL.new(ironment: ironment, err: err).exec_with_environment("foo")

        assert_equal "", err.string
      end
    end

    test_exception_handling Ironment::AccessDenied, "ironment: Permission denied", :exec_with_environment, "foo"
    test_exception_handling Ironment::NoEntity, "ironment: No such file or directory", :exec_with_environment, "foo"
    test_exception_handling Ironment::IsDirectory, "ironment: Is a directory", :exec_with_environment, "foo"
    test_exception_handling Ironment::MalformedRuncom, "ironment: Malformed runcom", :exec_with_environment, "foo"
  end

  describe "#trust" do
    describe "when succesfully trusting a file" do
      it "should not write to :stderr" do
        truster = Minitest::Mock.new
        truster.expect :trust, true, [Ironment::Runcom.new(".envrc")]

        err = StringIO.new

        Ironment::CL.new(truster: truster, err: err).trust(".envrc")

        assert_equal "", err.string
      end
    end

    test_exception_handling Ironment::AccessDenied, "ironment: Permission denied", :trust, ".envrc"
    test_exception_handling Ironment::NoEntity, "ironment: No such file or directory", :trust, ".envrc"
    test_exception_handling Ironment::IsDirectory, "ironment: Is a directory", :trust, ".envrc"
  end

  describe "#untrust" do
    describe "when succesfully untrusting a file" do
      it "should not write to :stderr" do
        truster = Minitest::Mock.new
        truster.expect :untrust, true, [Ironment::Runcom.new(".envrc")]

        err = StringIO.new

        Ironment::CL.new(truster: truster, err: err).untrust(".envrc")

        assert_equal "", err.string
      end
    end

    test_exception_handling Ironment::AccessDenied, "ironment: Permission denied", :untrust, ".envrc"
    test_exception_handling Ironment::NoEntity, "ironment: No such file or directory", :untrust, ".envrc"
    test_exception_handling Ironment::IsDirectory, "ironment: Is a directory", :untrust, ".envrc"
  end
end

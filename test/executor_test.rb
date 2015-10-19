require "test_helper"

def test_exception_mapping(map)
  from, to = map.flatten

  describe "when exec raises #{from.to_s}" do
    it "should raise #{to.to_s}" do
      exec = Object.new.tap do |exec|
        exec.define_singleton_method :exec do |*|
          raise from
        end
      end

      assert_raises to do
        Ironment::Executor.new(exec: exec).exec "foo"
      end
    end
  end
end

describe Ironment::Executor do
  describe "#exec" do
    test_exception_mapping Errno::EACCES => Ironment::AccessDenied
    test_exception_mapping Errno::ENOENT => Ironment::NoEntity
    test_exception_mapping Errno::EISDIR => Ironment::IsDirectory
  end
end

require "digest/sha1"

class Ironment
  class Truster
    class RuncomError < StandardError
      attr_reader :runcom

      def initialize(runcom)
        @runcom = runcom
      end
    end

    class NotTrusted < RuncomError; end
    class Modified < RuncomError; end

    def initialize(options = {})
      @config = options[:config] || Config.new
    end

    def validate(runcom)
      expected_sha1sum = @config[runcom.file]

      if expected_sha1sum.nil?
        raise NotTrusted, runcom
      end

      real_sha1sum = runcom.sha1sum

      unless expected_sha1sum == real_sha1sum
        raise Modified, runcom
      end

      true
    end

    def trust(runcom)
      @config[runcom.file] = runcom.sha1sum
    end

    def untrust(runcom)
      @config[runcom.file] = nil
    end
  end
end

require "pathname"

class Ironment
  class Finder
    def initialize
      @pwd = Pathname.pwd
    end

    def find
      Enumerator.new do |y|
        until @pwd.root?
          y << cdrc if has_cdrc?
          @pwd = @pwd.parent
        end

        y << cdrc if has_cdrc?
      end
    end

    private

    def has_cdrc?
      File.exist? cdrc
    end

    def cdrc
      File.join @pwd, Ironment.runcom
    end
  end
end

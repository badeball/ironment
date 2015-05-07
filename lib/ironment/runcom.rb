require "digest/sha1"

class Ironment
  class Runcom
    include PairReader

    attr_reader :file

    def initialize(file)
      @file = file
    end

    def sha1sum
      Digest::SHA1.hexdigest(File.read(@file))
    end

    def each_pair
      if block_given?
        read_pairs.each &Proc.new
      else
        read_pairs.each
      end
    end

    def ==(other)
      @file == other.file
    end
  end
end

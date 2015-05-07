require "digest/sha1"

class Ironment
  class Runcom
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def sha1sum
      Digest::SHA1.hexdigest(File.read(@file))
    end

    def each_pair
      pairs = Hash[*File.read(@file).split(/\n/).reject { |line|
        /^\s*#/ =~line
      }.map { |line|
        line.split(/=/)
      }.flatten]

      if block_given?
        pairs.each &Proc.new
      else
        pairs.each
      end
    end

    def ==(other)
      @file == other.file
    end
  end
end

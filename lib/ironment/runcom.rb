require "digest/sha1"

class Ironment
  class Runcom
    attr_reader :file

    def initialize(file)
      @file = File.expand_path file
    end

    def sha1sum
      Digest::SHA1.hexdigest(content)
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

    def content
      @content ||= File.read(file)
    end

    private

    def read_pairs
      Hash[*content.split(/\n/).reject { |line|
        /^\s*#/ =~line
      }.map { |line|
        raise MalformedRuncom unless line.include? "="
        line.split(/=/)
      }.flatten]
    end
  end
end

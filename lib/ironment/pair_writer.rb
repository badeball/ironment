require "fileutils"
require "pathname"

class Ironment
  module PairWriter
    def write_pairs(pairs)
      dir = Pathname.new(file).dirname

      unless dir.exist?
        dir.mkpath
      end

      File.write(file, pairs.map { |k, v| "#{k}=#{v}" }.join("\n"))
    end
  end
end

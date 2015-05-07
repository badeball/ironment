class Ironment
  module PairReader
    def read_pairs
      if File.exist?(file)
        Hash[*File.read(file).split(/\n/).reject { |line|
          /^\s*#/ =~line
        }.map { |line|
          line.split(/=/)
        }.flatten]
      else
        {}
      end
    end
  end
end

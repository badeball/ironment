class Ironment
  module PairReader
    def read_pairs
      Hash[*File.read(file).split(/\n/).reject { |line|
        /^\s*#/ =~line
      }.map { |line|
        line.split(/=/)
      }.flatten]
    end
  end
end

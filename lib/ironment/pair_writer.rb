class Ironment
  module PairWriter
    def write_pairs(pairs)
      File.write(file, pairs.map { |k, v| "#{k}=#{v}" }.join("\n"))
    end
  end
end

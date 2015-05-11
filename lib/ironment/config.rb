class Hash
  def except(*keys)
    dup.except!(*keys)
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end
end

class Ironment
  class Config
    class << self
      attr_writer :config_path

      def config_path
        @config_path || default_config_path
      end

      def default_config_path
        File.join(Dir.home, ".config", "ironment", "config")
      end
    end

    def [](key)
      read_pairs[key]
    end

    def []=(key, value)
      if value.nil?
        write_pairs read_pairs.except(key)
      else
        write_pairs read_pairs.merge(key => value)
      end
    end

    private

    def read_pairs
      if File.exist?(file)
        Hash[*File.read(file).split(/\n/).map { |line|
          line.split(/=/)
        }.flatten]
      else
        {}
      end
    end

    def write_pairs(pairs)
      dir = Pathname.new(file).dirname

      unless dir.exist?
        dir.mkpath
      end

      File.write(file, pairs.map { |k, v| "#{k}=#{v}" }.join("\n"))
    end

    def file
      self.class.config_path
    end
  end
end

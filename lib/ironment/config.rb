require "ironment/pair_reader"
require "ironment/pair_writer"

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

    include PairReader
    include PairWriter

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

    def file
      self.class.config_path
    end
  end
end

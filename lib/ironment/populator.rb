class Ironment
  class Populator
    def initialize(options = {})
      @env = options[:env] || ENV
    end

    def populate_with(name)
      File.readlines(name).each do |line|
        key, value = line.strip.split "="
        @env[key] = value
      end
    end
  end
end

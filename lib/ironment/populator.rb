class Ironment
  class Populator
    def populate_with(name)
      File.readlines(name).each do |line|
        key, value = line.strip.split "="
        ENV[key] = value
      end
    end
  end
end

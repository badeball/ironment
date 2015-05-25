class Ironment
  class Populator
    def initialize(options = {})
      @env = options[:env] || ENV
    end

    def populate_with(runcom)
      enum = runcom.each_pair

      loop do
        @env.[]= *enum.next
      end
    end
  end
end

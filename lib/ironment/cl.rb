class Ironment
  class CL
    class << self
      def rescue_common_exceptions(method_name)
        new_name = "original_#{method_name}"

        alias_method new_name, method_name

        define_method method_name do |*args|
          begin
            send new_name, *args
          rescue Ironment::AccessDenied
            @err.puts "ironment: Permission denied"
          rescue Ironment::NoEntity
            @err.puts "ironment: No such file or directory"
          rescue Ironment::IsDirectory
            @err.puts "ironment: Is a directory"
          rescue Ironment::MalformedRuncom
            @err.puts "ironment: Malformed runcom"
          end
        end
      end
    end

    def initialize(options = {})
      @ironment = options[:ironment] || Ironment.new(options)
      @prompter = options[:prompter] || Prompter.new
      @err = options[:err] || $stderr
    end

    def exec_with_environment(command, *args)
      begin
        @ironment.exec_with_environment command, *args
      rescue Truster::NotTrusted => e
        if @prompter.not_trusted e.runcom
          exec_with_environment command, *args
        end
      rescue Truster::Modified => e
        if @prompter.modified e.runcom
          exec_with_environment command, *args
        end
      end
    end

    rescue_common_exceptions :exec_with_environment

    def trust(file)
      @ironment.trust file
    end

    rescue_common_exceptions :trust

    def untrust(file)
      @ironment.untrust file
    end

    rescue_common_exceptions :untrust
  end
end

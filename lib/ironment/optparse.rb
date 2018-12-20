class Ironment
  class Optparse
    HELP_OPTIONS = ["-h", "--help"]
    VERSION_OPTIONS = ["-v", "--version"]

    def initialize(options = {})
      @argv = options[:argv] || ARGV
      @stdout = options[:stdout] || $stdout
      @stderr = options[:stderr] || $stderr
      @cl = options[:cl] || CL.new
    end

    def parse
      if include_version?(@argv)
        @stdout.puts "Ironment #{VERSION}"
        return
      end

      unknown_options = options(@argv) - HELP_OPTIONS - VERSION_OPTIONS

      if !unknown_options.empty?
        @stderr.puts "Unknown option: #{unknown_options.first}"
        return 1
      end

      case @argv.first
      when "help"
        case @argv[1]
        when "exec"
          @stdout.puts EXEC_HELP_TEXT
        when "trust"
          @stdout.puts TRUST_HELP_TEXT
        when "untrust"
          @stdout.puts UNTRUST_HELP_TEXT
        when "help", nil
          @stdout.puts BASE_HELP_TEXT
        else
          @stderr.puts "Unknown command: #{@argv[1]}"
          return 1
        end
      when "trust"
        return @stdout.puts TRUST_HELP_TEXT if include_help?(@argv)
        @argv.drop(1).each do |arg|
          @cl.trust arg
        end
      when "untrust"
        return @stdout.puts UNTRUST_HELP_TEXT if include_help?(@argv)
        @argv.drop(1).each do |arg|
          @cl.untrust arg
        end
      when "exec"
        return @stdout.puts EXEC_HELP_TEXT if include_help?(@argv)
        @cl.exec_with_environment *@argv.drop(1)
      else
        return @stdout.puts BASE_HELP_TEXT if include_help?(@argv)
        return @stdout.puts BASE_HELP_TEXT if @argv.empty?
        @cl.exec_with_environment *@argv
      end
    end

    private

    def include_help?(argv)
      !(options(argv) & HELP_OPTIONS).empty?
    end

    def include_version?(argv)
      !(options(argv) & VERSION_OPTIONS).empty?
    end

    def options(argv)
      if ["help", "exec", "trust", "untrust"].include?(argv.first)
        argv = argv.drop(1)
      end

      argv.take_while do |arg|
        arg.start_with?("-")
      end
    end
  end
end

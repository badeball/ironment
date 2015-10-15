class Ironment
  class CL
    def initialize(options = {})
      @ironment = options[:ironment] || Ironment.new
      @prompter = options[:prompter] || Prompter.new
      @truster = options[:truster] || Truster.new
      @err = options[:err] || $stderr
    end

    def exec_with_environment(command, *args)
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

    def trust(file)
      @truster.trust Runcom.new(file)
    rescue Errno::EACCES
      @err.puts "ironment: Permission denied"
    rescue Errno::ENOENT
      @err.puts "ironment: No such file or directory"
    rescue Errno::EISDIR
      @err.puts "ironment: Is a directory"
    end

    def untrust(file)
      @truster.untrust Runcom.new(file)
    rescue Errno::EACCES
      @err.puts "ironment: Permission denied"
    rescue Errno::ENOENT
      @err.puts "ironment: No such file or directory"
    rescue Errno::EISDIR
      @err.puts "ironment: Is a directory"
    end
  end
end

class Ironment
  class CL
    def initialize(options = {})
      @ironment = options[:ironment] || Ironment.new
      @prompter = options[:prompter] || Prompter.new
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
  end
end

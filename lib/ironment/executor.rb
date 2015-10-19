require "ironment/exec"

class Ironment
  class Executor
    def initialize(options = {})
      @exec = options[:exec] || Exec.new
    end

    def exec(command, *args)
      @exec.exec command, *args
    rescue Errno::EACCES
      raise AccessDenied
    rescue Errno::ENOENT
      raise NoEntity
    rescue Errno::EISDIR
      raise IsDirectory
    end
  end
end

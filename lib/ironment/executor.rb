require "ironment/exec"

class Ironment
  class Executor
    def initialize(options = {})
      @exec = options[:exec] || Exec.new
    end

    def exec(command, *args)
      @exec.exec command, *args
    rescue Errno::EACCES
      raise AccessDenied, command
    rescue Errno::ENOENT
      raise NoEntity, command
    rescue Errno::EISDIR
      raise IsDirectory, command
    end
  end
end

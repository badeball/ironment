class Ironment
  class Executor
    def exec(command, *args)
      Kernel.exec command, *args
    end
  end
end

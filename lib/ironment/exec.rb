class Ironment
  class Exec
    def exec(command, *args)
      Kernel.exec command, *args
    end
  end
end

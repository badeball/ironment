require "ironment/finder"
require "ironment/pair_reader"
require "ironment/populator"
require "ironment/executor"
require "ironment/runcom"

class Ironment
  class << self
    attr_writer :runcom

    def runcom
      @runcom || default_runcom
    end

    def default_runcom
      ".envrc"
    end
  end

  def initialize(options = {})
    @finder = options[:finder] || Finder.new
    @populator = options[:populator] || Populator.new
    @executor = options[:executor] || Executor.new
  end

  def exec_with_environment(command, *args)
    load_environment
    @executor.exec command, *args
  end

  def load_environment
    @finder.find.each do |runcom|
      @populator.populate_with runcom
    end
  end
end

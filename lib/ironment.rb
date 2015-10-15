require "ironment/cl"
require "ironment/config"
require "ironment/finder"
require "ironment/populator"
require "ironment/cl/prompter"
require "ironment/executor"
require "ironment/runcom"
require "ironment/truster"

class Ironment
  class MalformedRuncom < StandardError; end

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
    @truster = options[:truster] || Truster.new
    @finder = options[:finder] || Finder.new
    @populator = options[:populator] || Populator.new
    @executor = options[:executor] || Executor.new
  end

  def exec_with_environment(command, *args)
    load_environment
    @executor.exec command, *args
  end

  def trust(file)
    @truster.trust Runcom.new file
  end

  def untrust(file)
    @truster.untrust Runcom.new file
  end

  private

  def load_environment
    @finder.find.each do |runcom|
      @truster.validate runcom
      @populator.populate_with runcom
    end
  end
end

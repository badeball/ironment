require "test_helper"
require "minitest/autorun"
require "fakefs/safe"
require "ironment"

describe Ironment::Populator do
  it "should populate the environment with the runcom's key-value pairs" do
    runcom = Minitest::Mock.new
    runcom.expect :each_pair, {"BAR" => "1", "BAZ" => "2"}.each

    env = Minitest::Mock.new
    env.expect :[]=, "1", ["BAR", "1"]
    env.expect :[]=, "2", ["BAZ", "2"]

    Ironment::Populator.new(
      env: env
    ).populate_with runcom

    env.verify
  end
end

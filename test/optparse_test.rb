require "stringio"

def truncate(string, options = {})
  max = options.fetch(:max, 20)

  if string.length > max
    "#{string[0..max]} (...)"
  else
    string
  end
end

def test_optparse_passthrough(options)
  argv = options.delete(:argv)

  raise ArgumentError, "Expected a single expectation" unless options.size == 1

  expectation, arguments = options.first

  it "should parse \"#{argv.join(" ")}\" and invoke ##{expectation} with #{arguments.inspect}" do
    cl = Minitest::Mock.new
    cl.expect expectation, nil, arguments

    Ironment::Optparse.new(
      cl: cl,
      argv: argv
    ).parse

    cl.verify
  end
end

def test_optparse_stdout(options)
  argv, stdout = options.values_at(:argv, :stdout)

  it "should parse \"#{argv.join(" ")}\" and output #{truncate(stdout).inspect}" do
    actual_stdout = StringIO.new

    Ironment::Optparse.new(
      cl: Minitest::Mock.new, # Dummmy mock without expectations
      argv: argv,
      stdout: actual_stdout
    ).parse

    assert_equal stdout, actual_stdout.string
  end
end

def test_optparse_stderr(options)
  argv, stderr = options.values_at(:argv, :stderr)

  it "should parse \"#{argv.join(" ")}\" and output #{truncate(stderr).inspect}" do
    actual_stderr = StringIO.new

    Ironment::Optparse.new(
      cl: Minitest::Mock.new, # Dummmy mock without expectations
      argv: argv,
      stderr: actual_stderr
    ).parse

    assert_equal stderr, actual_stderr.string
  end
end

def test_optparse_ret_value(options)
  argv, ret_value = options.values_at(:argv, :ret_value)

  it "should parse \"#{argv.join(" ")}\" and return #{ret_value}" do
    actual_stderr = StringIO.new

    actual_ret_value = Ironment::Optparse.new(
      cl: Minitest::Mock.new, # Dummmy mock without expectations
      argv: argv,
      stdout: StringIO.new,
      stderr: StringIO.new
    ).parse

    assert_equal ret_value, actual_ret_value
  end
end

describe Ironment::Optparse do
  test_optparse_passthrough argv: ["foo"], exec_with_environment: ["foo"]
  test_optparse_passthrough argv: ["foo", "--bar"], exec_with_environment: ["foo", "--bar"]
  test_optparse_passthrough argv: ["foo", "--help"], exec_with_environment: ["foo", "--help"]
  test_optparse_passthrough argv: ["exec", "foo"], exec_with_environment: ["foo"]
  test_optparse_passthrough argv: ["trust", "foo"], trust: ["foo"]
  test_optparse_passthrough argv: ["untrust", "foo"], untrust: ["foo"]

  test_optparse_stdout argv: [], stdout: Ironment::Optparse::BASE_HELP_TEXT
  test_optparse_stdout argv: ["-h"], stdout: Ironment::Optparse::BASE_HELP_TEXT
  test_optparse_stdout argv: ["--help"], stdout: Ironment::Optparse::BASE_HELP_TEXT
  test_optparse_stdout argv: ["help"], stdout: Ironment::Optparse::BASE_HELP_TEXT

  test_optparse_stdout argv: ["exec", "-h"], stdout: Ironment::Optparse::EXEC_HELP_TEXT
  test_optparse_stdout argv: ["exec", "--help"], stdout: Ironment::Optparse::EXEC_HELP_TEXT
  test_optparse_stdout argv: ["help", "exec"], stdout: Ironment::Optparse::EXEC_HELP_TEXT

  test_optparse_stdout argv: ["trust", "-h"], stdout: Ironment::Optparse::TRUST_HELP_TEXT
  test_optparse_stdout argv: ["trust", "--help"], stdout: Ironment::Optparse::TRUST_HELP_TEXT
  test_optparse_stdout argv: ["help", "trust"], stdout: Ironment::Optparse::TRUST_HELP_TEXT

  test_optparse_stdout argv: ["untrust", "-h"], stdout: Ironment::Optparse::UNTRUST_HELP_TEXT
  test_optparse_stdout argv: ["untrust", "--help"], stdout: Ironment::Optparse::UNTRUST_HELP_TEXT
  test_optparse_stdout argv: ["help", "untrust"], stdout: Ironment::Optparse::UNTRUST_HELP_TEXT

  test_optparse_stdout argv: ["-v"], stdout: "Ironment #{Ironment::VERSION}\n"
  test_optparse_stdout argv: ["--version"], stdout: "Ironment #{Ironment::VERSION}\n"

  test_optparse_stderr argv: ["--foo", "bar"], stderr: "Unknown option: --foo\n"
  test_optparse_ret_value argv: ["--foo", "bar"], ret_value: 1

  test_optparse_stderr argv: ["help", "foo"], stderr: "Unknown command: foo\n"
  test_optparse_ret_value argv: ["help", "foo"], ret_value: 1

  it "should invoke #trust once for each argument" do
    cl = Minitest::Mock.new
    cl.expect :trust, nil, ["foo"]
    cl.expect :trust, nil, ["bar"]

    Ironment::Optparse.new(
      cl: cl,
      argv: ["trust", "foo", "bar"]
    ).parse

    cl.verify
  end

  it "should invoke #untrust once for each argument" do
    cl = Minitest::Mock.new
    cl.expect :untrust, nil, ["foo"]
    cl.expect :untrust, nil, ["bar"]

    Ironment::Optparse.new(
      cl: cl,
      argv: ["untrust", "foo", "bar"]
    ).parse

    cl.verify
  end
end

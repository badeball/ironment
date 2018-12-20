class Ironment
  class Optparse
    class << self
      private

      def unindent(s)
        s.gsub(/^#{s.scan(/^[ \t]+(?=\S)/).min}/, '')
      end
    end

    BASE_HELP_TEXT = unindent(<<-TXT)
      Environment populator & command wrapper utility.

      \e[1mUSAGE\e[0m

        $ iron COMMAND [OPTIONS]...

      \e[1mCOMMANDS\e[0m

        exec     Create a new environment (default)
        help     Display global or [command] help documentation
        trust    Add a file as trusted
        untrust  Remove a file as trusted

      \e[1mGLOBAL OPTIONS\e[0m

        -h, --help
            Display help documentation

        -v, --version
            Display version information
    TXT

    EXEC_HELP_TEXT = unindent(<<-TXT)
      Create a new environment

      \e[1mUSAGE\e[0m

        $ iron exec COMMAND [ARG]...
        $ iron COMMAND [ARG]...

      \e[1mGLOBAL OPTIONS\e[0m

        -h, --help
            Display help documentation

        -v, --version
            Display version information
    TXT

    TRUST_HELP_TEXT = unindent(<<-TXT)
      Add a file / files as trusted

      \e[1mUSAGE\e[0m

        $ iron trust [FILE]...

      \e[1mGLOBAL OPTIONS\e[0m

        -h, --help
            Display help documentation

        -v, --version
            Display version information
    TXT

    UNTRUST_HELP_TEXT = unindent(<<-TXT)
      Remove a file / files as trusted

      \e[1mUSAGE\e[0m

        $ iron untrust [FILE]...

      \e[1mGLOBAL OPTIONS\e[0m

        -h, --help
            Display help documentation

        -v, --version
            Display version information
    TXT
  end
end

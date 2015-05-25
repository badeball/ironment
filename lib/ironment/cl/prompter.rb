class Ironment
  class CL
    class Prompter
      def initialize(options = {})
        @in = options[:in] || $stdin
        @out = options[:out] || $stdout
        @truster = options[:truster] || Truster.new
      end

      def not_trusted(runcom)
        prompt_not_trusted(runcom)
        request_user_action(runcom)
      end

      def modified(runcom)
        prompt_modified(runcom)
        request_user_action(runcom)
      end

      def request_user_action(runcom)
        prompt_question

        case @in.gets.strip.to_sym
        when :y
          @truster.trust(runcom)
          true
        when :v
          prompt_content(runcom)
          request_user_action(runcom)
        when :n
          false
        else
          request_user_action(runcom)
        end
      end

      private

      def prompt_not_trusted(runcom)
        @out.write <<-PROMPT
Ironment has encountered a new and untrusted .envrc file. This
may contain untrusted content and should be examined manually.

  #{runcom.file} (#{runcom.sha1sum})

        PROMPT
      end

      def prompt_modified(runcom)
        @out.write <<-PROMPT
Ironment has encountered a trusted, but modified .envrc file. This
may contain untrusted content and should be examined manually.

  #{runcom.file} (#{runcom.sha1sum})

        PROMPT
      end

      def prompt_question
        @out.write <<-PROMPT.gsub(/\n$/, "")
Do you wish to trust this .envrc file?
y[es], n[o], v[iew]> 
        PROMPT
      end

      def prompt_content(runcom)
        @out.write "\n#{runcom.content.gsub(/^/, "  ")}\n"
      end
    end
  end
end

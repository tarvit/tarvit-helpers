module TarvitHelpers

  class ConditionalLogger
    def initialize(&condition)
      @quiet = !condition.call
    end

    def puts *message
      return if @quiet
      Kernel::puts *message
    end

    def print *message
      return if @quiet
      Kernel::puts *message
    end

    def log *message
      puts *message
    end
  end

  class LogQuiet < ConditionalLogger

    def self.apply(context, env_var)
      var_set = !!ENV[env_var]

      unless var_set
        context.instance_eval do
          def puts(*message); end
          def print(*message);end
        end
      end
    end
  end

end

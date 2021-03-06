module TarvitHelpers
  module HashPresenter
    class Cached < Simple
      def initialize(hash, levels=[], parent=nil)
        super
        @cache = {}
      end

      def _value(method_name)
        @cache[method_name] ||= super
      end
    end
  end
end

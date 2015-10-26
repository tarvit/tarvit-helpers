module TarvitHelpers
  module HashPresenter
    class CachedHashPresenter < SimpleHashPresenter
      def initialize(hash, levels=[])
        super
        @cache = {}
      end

      def _value(method_name)
        @cache[method_name] ||= super
      end
    end
  end
end


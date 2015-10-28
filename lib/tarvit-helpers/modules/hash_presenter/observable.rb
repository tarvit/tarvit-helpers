module TarvitHelpers
  module HashPresenter
    class Observable < Simple
      def initialize(hash, levels=[], parent=nil)
        @_hash = hash
        @_levels = levels
      end

      def _hash
        _prepare_keys(@_hash)
      end
    end
  end
end

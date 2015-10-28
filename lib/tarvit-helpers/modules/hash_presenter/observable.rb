module TarvitHelpers
  module HashPresenter
    class Observable < Simple
      def initialize(hash, levels=[], parent=nil)
        super
        @_hash = hash
      end

      def _hash
        _prepare_keys(@_hash)
      end
    end
  end
end

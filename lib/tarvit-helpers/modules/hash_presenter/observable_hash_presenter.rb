module TarvitHelpers
  module HashPresenter
    class ObservableHashPresenter < SimpleHashPresenter
      def initialize(hash, levels=[])
        @_hash = hash
        @_levels = levels
      end

      def _hash
        _prepare_keys(@_hash)
      end
    end
  end
end

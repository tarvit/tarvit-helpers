module TarvitHelpers
  module HashPresenter
    require_relative '../modules/hash_presenter/simple_hash_presenter'
    require_relative '../modules/hash_presenter/cached_hash_presenter'
    require_relative '../modules/hash_presenter/observable_hash_presenter'
    require_relative '../modules/hash_presenter/custom_hash_presenter'

    def self.present(hash, option = :cached )
      raise ArgumentError.new("#{ hash.class } is not a Hash") unless hash.is_a?(Hash)
      factory[option].new(hash)
    end

    def self.factory
      { cached: Cached, observable: Observable }
    end

  end
end

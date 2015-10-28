module TarvitHelpers
  module HashPresenter
    require_relative '../modules/hash_presenter/simple'
    require_relative '../modules/hash_presenter/cached'
    require_relative '../modules/hash_presenter/observable'
    require_relative '../modules/hash_presenter/with_rules'
    require_relative '../modules/hash_presenter/custom'

    def self.present(hash, option = :cached )
      raise ArgumentError.new("#{ hash.class } is not a Hash") unless hash.is_a?(Hash)
      factory[option].new(hash)
    end

    def self.factory
      { cached: Cached, observable: Observable }
    end

  end
end

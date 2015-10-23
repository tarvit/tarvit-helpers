module TarvitHelpers
  module HashPresenter

    def self.present(hash, option = :cached )
      raise ArgumentError.new("#{ hash.class } is not a Hash") unless hash.is_a?(Hash)
      factory[option].new(hash)
    end

    def self.factory
      { cached: CachedHashPresenter, observable: ObservableHashPresenter }
    end

    class SimpleHashPresenter
      require 'active_support/core_ext/string'

      attr_reader :_hash

      def initialize(hash)
        @_hash = prepare_keys(hash)
      end

      def method_missing(m, *args)
        return value(m) if accessor_method?(m)
        super
      end

      protected

      def value(method_name)
        res = self._hash[method_name]
        transform_value(res)
      end

      def transform_value(x)
        return x.map{|x| transform_value(x) } if x.is_a?(Array)
        x.is_a?(Hash) ? self.class.new(x) : x
      end

      def accessor_method?(method_name)
        self._hash.keys.include?(method_name)
      end

      def key_to_method(key)
        key.to_s.gsub(/\s+/, ?_).underscore.to_sym
      end

      def prepare_keys(hash)
        res = hash.map do |k ,v|
          [ key_to_method(k), v ]
        end
        Hash[res]
      end

    end

    class CachedHashPresenter < SimpleHashPresenter

      def initialize(hash)
        super
        @cache = {}
      end

      def value(method_name)
        @cache[method_name] ||= super
      end

    end

    class ObservableHashPresenter < SimpleHashPresenter
      def initialize(hash)
        @_hash = hash
      end

      def _hash
        prepare_keys(@_hash)
      end
    end

  end
end


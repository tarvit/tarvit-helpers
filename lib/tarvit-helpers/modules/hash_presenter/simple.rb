module TarvitHelpers
  module HashPresenter

    class Simple
      require 'active_support/core_ext/string'

      attr_reader :_hash, :_levels, :_parent

      def initialize(hash, levels=[], parent=nil)
        @_hash = _modify_hash(_prepare_keys(hash))
        @_levels = levels
        @_parent = parent
      end

      def _root?
        _parent.nil?
      end

      def method_missing(m, *args)
        return _value(m) if _accessor_method?(m)
        super
      end

      protected

      def _value(method_name)
        _transform_value(method_name, _hash_value(method_name))
      end

      def _hash_value(method_name)
        _hash[method_name]
      end

      def _transform_value(method_name, value)
        return value.map{|key| _transform_value(method_name, key) } if value.is_a?(Array)
        value.is_a?(Hash) ? _new_level_presenter(value, method_name) : value
      end

      def _accessor_method?(method_name)
        self._hash.keys.include?(method_name)
      end

      def _key_to_method(key)
        key.to_s.gsub(/\s+/, ?_).underscore.to_sym
      end

      def _prepare_keys(hash)
        res = hash.map do |k ,v|
          [ _key_to_method(k), v ]
        end
        Hash[res]
      end

      def _path(key)
        _levels + [ key ]
      end

      def _new_level_presenter(value, method_name)
        _new_level_presenter_klass.new(value, _path(method_name), self)
      end

      def _new_level_presenter_klass
        self.class
      end

      def _modify_hash(hash)
        hash
      end
    end
  end
end

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

      attr_reader :_hash, :_levels

      def initialize(hash, levels=[])
        @_hash = _prepare_keys(hash)
        @_levels = levels
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
        self.class.new(value, _path(method_name))
      end

    end

    class CachedHashPresenter < SimpleHashPresenter
      def initialize(hash, levels=[])
        super
        @cache = {}
      end

      def _value(method_name)
        @cache[method_name] ||= super
      end
    end

    class ObservableHashPresenter < SimpleHashPresenter
      def initialize(hash, levels=[])
        @_hash = hash
        @_levels = levels
      end

      def _hash
        _prepare_keys(@_hash)
      end
    end

    class CustomHashPresenter < CachedHashPresenter
      attr_reader :_rules_holder

      def initialize(hash, levels=[], rules_holder=nil, &rules)
        super(hash, levels)
        @_rules_holder = rules_holder || _init_rules_holder
        _init_rules
        rules.call(_rules_holder) if rules
      end

      def _current_path(method_name)
        _levels + [ method_name ]
      end

      protected

      def _hash_value(method_name)
        value =  super
        rule = _rules_holder.rule_for(_path(method_name))
        rule ? rule.value_transformer.call(value, self) : value
      end

      def _new_level_presenter(value, method_name)
        self.class.new(value, _path(method_name), _rules_holder)
      end

      def _init_rules; end

      def _init_rules_holder
        RulesHolder.new
      end

      def _accessor_method?(method_name)
        super(method_name) || _rules_holder.rules.map{|r| r.path.last }.include?(method_name)
      end

      alias_method :_rules, :_rules_holder

      class RulesHolder
        attr_reader :rules

        def initialize
          @rules = []
        end

        def when(path, &_transform_value)
          self.rules << Rule.new(path, _transform_value)
        end

        def rule_for(path)
          rules.find{|r| r.path == path }
        end
      end

      class Rule
        attr_reader :path, :value_transformer
        def initialize(path, value_transformer)
          @path, @value_transformer = path, value_transformer
        end
      end
    end
  end
end

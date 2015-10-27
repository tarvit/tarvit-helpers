module TarvitHelpers
  module HashPresenter

    class WithRules < Cached
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

module TarvitHelpers
  module HashPresenter

    class Custom < WithRules

      def _custom_hash
        _rules_holder.rules.each_with_object(_hash.clone) do |rule, res|
          _apply_rule(res, rule, rule.path.clone, [])
        end
      end

      protected

      def _apply_rule(node, rule, rule_path, current_path)
        current_level = rule_path.shift

        if rule_path.empty?
          presenter = _path_presenter(current_path)
          node[ current_level ] = rule.value_transformer.call(node[current_level], presenter)
          return
        end

        current_node = node[current_level]
        current_path << current_level

        if current_node.is_a?(Array)
          current_node.each_with_index do |el, index|
            path = current_path.clone
            path << index
            _apply_rule(current_node[index], rule, rule_path.clone, path)
          end
        else
          _apply_rule(current_node, rule, rule_path.clone, current_path.clone)
        end
      end

      def _path_presenter(path)
        res = self
        path.each do |level|
          res = res.is_a?(Array) ? res[level] : res.send(level)
        end
        res
      end

    end
  end
end

module TarvitHelpers
  module NonSharedAccessors
    require 'active_support'
    extend ActiveSupport::Concern

    module ClassMethods
      def non_shared_cattr_accessor(*keys)
        keys.each do |key|
          raise "#{key} is not a Symbol" unless key.is_a?(Symbol)
          method=<<METHOD
            def #{key}
              get_non_shared(:#{ key })
            end

            def #{key}=(v)
              set_non_shared(:#{ key },v)
            end
METHOD
          eval(method)
        end
      end

      private

      def global_shared_store
        @global_shared_values ||= {}
      end

      def own_store
        global_shared_store[self] ||= {}
      end

      def get_non_shared(key)
        own_store[key]
      end

      def set_non_shared(key,value)
        own_store[key]=value
      end
    end
  end
end
module TarvitHelpers
  class HashPresenter
    require 'active_support/core_ext/string'

    attr_reader :hash

    def initialize(hash)
      @hash = prepare_keys(hash)
    end

    def method_missing(m, *args)
      return value(m) if accessor_method?(m)
      super
    end

    protected

    def value(method_name)
      res = @hash[method_name]
      transform_value(res)
    end

    def transform_value(x)
      return x.map{|x| transform_value(x) } if x.is_a?(Array)
      x.is_a?(Hash) ? self.class.new(x) : x
    end

    def accessor_method?(method_name)
      @hash.keys.include?(method_name)
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
end

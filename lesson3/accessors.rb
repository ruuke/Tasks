module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessors_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history = "@#{name}_history".to_sym

        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}_history") { instance_variable_get(var_history) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          instance_variable_set(var_history, []) if instance_variable_get(var_history).nil?
          instance_variable_get(var_history) << value
        end
      end
    end

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise TypeError, "Значение #{name} не соответсвует #{class_name}" unless value.is_a?(class_name)
      instance_variable_set(var_name, value)
      end
    end
  end
end

class Test
  include Accessors

  attr_accessors_with_history :a, :b, :c
  strong_attr_accessor :d, :e
end

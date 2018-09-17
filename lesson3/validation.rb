module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, *params)
      @validations ||= []
      @validations << {attr: name, type: type, params: params}
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |attr|
        method = "validate_#{attr[:type]}".to_sym
        send(method, attr[:attr], attr[:params])
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    protected

    def validate_presence(attr, params)
      value = instance_variable_get("@#{attr}")
      raise "Значение #{attr} не должно быть пустным" if value.empty? || value.nil?
    end

    def validate_type(attr, class_name)
      value = instance_variable_get("@#{attr}")
      if value.is_a? Array
        value.each do |i|
          raise "#{i} не является элементом #{class_name}" unless i.is_a? class_name
        end
      else
        raise "#{attr} не является элементом #{class_name}" unless value.is_a? class_name
      end
    end

    def validate_format(attr, format)
      value = instance_variable_get("@#{attr}")
      raise "Неверно указан формат" unless value =~ format
    end
  end
end

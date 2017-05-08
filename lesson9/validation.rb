module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end

    def validate!
      self.class.instance_variable_get(:@validations).each do |validation|
        var_name = validation[:name]
        method_name = "validate_#{validation[:type].to_s}".to_sym
        if validation[:type] == :presence
          send method_name, var_name
        else
          send method_name, var_name, validation[:param]
        end
      end
    end

    protected

    def validate_presence(name)
      value = instance_variable_get("#{name}".to_sym)
      if value
        if (value.is_a? String) && value.strip == ''
          raise "Значение переменной #{name} должно быть НЕ пустой строкой"
        end
      else
        raise "Значение переменной #{name} должно быть заполнено"
      end
    end

    def validate_type(name, type)
      value = instance_variable_get("#{name}".to_sym)
      unless value.is_a? type
        raise "Значение переменной #{name} не соответствует указанному типу #{type.to_s}"
      end
    end

    def validate_format(name, format)
      value = instance_variable_get("#{name}".to_sym)
      unless format.match(value)
        raise "Значение переменной #{name} не соответствует формату #{format.to_s}"
      end
    end
  end

  module ClassMethods
    def validate(field_name, *args)
      name = "@#{field_name.to_s}"
      unless instance_variable_defined? (:@validations)
        @validations = []
      end
      type = args[0]
      param = args[1]
      if type != :presence && type != :format && type != :type
        raise "Неизвестный тип валидации"
      end
      if type == :format && !(param.is_a? Regexp)
        raise "Для проверки формата должно передаваться регулярное выражение"
      end
      if type == :type && !(param.is_a? Class)
        raise "Для проверки на тип данных должен указываться класс"
      end
      @validations << { name: name, type: type, param: param }
    end
  end
end

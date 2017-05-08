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
        self.class.do_validation(var_name, instance_variable_get("#{var_name}".to_sym),
                                 validation[:type],validation[:param])
      end
    end
  end

  module ClassMethods
    def do_validation(name, value, type, param)
      case type
      when :presence
        if value
          if (value.is_a? String) && value.strip == ''
            raise "Значение переменной #{name} должно быть НЕ пустой строкой"
          end
        else
          raise "Значение переменной #{name} должно быть заполнено"
        end
      when :format
        unless param.match(value)
          raise "Значение переменной #{name} не соответствует формату #{param.to_s}"
        end
      when :type
        unless value.is_a? param
          raise "Значение переменной #{name} не соответствует указанному типу #{param.to_s}"
        end
      end
    end

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

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
      methods.each do |method|
        if method.to_s =~ /^validate_.*/
          send method
        end
      end
    end
  end

  module ClassMethods
    def validate(field_name, *args)
      name = "@#{field_name.to_s}".to_sym
      type = args[0]
      method_name = "validate_#{field_name.to_s}_#{type.to_s}".to_sym
      case type
      when :presence
        define_method(method_name) do
          var_value = instance_variable_get name
          if var_value
            if var_value.class == String && var_value.strip == ''
              raise "Значение переменной должно быть НЕ пустой строкой"
            else
              true
            end
          else
            raise "Значение переменной должно быть заполнено"
          end
        end
      when :format
        regex = args[1]
        if regex.class != Regexp
          raise "Для проверки формата должно передаваться регулярное выражение"
        end
        define_method(method_name) do 
          unless regex.match(instance_variable_get name) 
            raise "Значение переменной не соответствует формату"
          else
            true
          end
        end
      when :type
        check_type = args[1]
        define_method(method_name) do
          var_value = instance_variable_get name
          if var_value.class != check_type
            raise "Значение переменной не соответствует указанному типу"
          else
            true
          end
        end
      else
        raise "Неизвестный тип валидации"
      end
    end
  end
end

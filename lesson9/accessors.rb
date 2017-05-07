module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*var_names)
      var_names.each do |name|
        var_name = "@#{name}".to_sym
        var_history_name = "@#{name}_history".to_sym
      
        define_method(name.to_sym) { instance_variable_get(var_name) }
        
        define_method("#{name}_history".to_sym) do
          instance_variable_get(var_history_name)
        end
      
        define_method("#{name}=".to_sym) do |value|
          history = instance_variable_get(var_history_name)
          if history
            history << value
            instance_variable_set(var_history_name, history)
          else
            instance_variable_set(var_history_name, [value])
          end
          instance_variable_set(var_name,value)
        end
      end
    end

    def strong_attr_accessor(name, var_type)
      var_name_sym = "@#{name}".to_sym
      
      define_method(name.to_sym) { instance_variable_get(var_name_sym) }
      
      define_method("#{name}=".to_sym) do |value|
        unless value.is_a? var_type
         raise TypeError, "Присваиваемое значение должно быть #{var_type} типа"
        end
        instance_variable_set(var_name_sym, value)
      end
    end
  end
end

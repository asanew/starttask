# Счетчик экземпляров класса

module InstanceCounter
  def included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    def instances
      class_variable_get :@@inst
    end
  end

  module InstanceMethods
    
    @@inst = 0
    
    def register_instance
      @@inst += 1
    end
  end
end

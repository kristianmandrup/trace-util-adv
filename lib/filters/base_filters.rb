module Tracing

  # abstract filter  
  class BaseFilter
    attr_reader :name
    attr_accessor :rules

    class << self
      attr_accessor :filters
    
      # register symbol => filter mappings
      def register_filters(hash)
        @filters ||= {}
        filters.merge!(hash)
      end

      # array of symbols
      # [:special_filter, :stream_filter]
      def unregister_filters(hash)
        @filters ||= {}
        filters.reject!{|key, value| hash.include? key}
      end    
    end
  
    def initialize(options = {})
      @name = options[:name] || "Unknown filter"      
    end
    
    def name_allow_action(name)
      res = rules.rules_allow_action(name)
    end
  end

  # filter on module
  class ModuleFilter < BaseFilter
    def initialize(options)
      super(options)
      @rules = options[:module_rules] || {}
    end

    def allow_action(msg, context)
      name = context[:full_modules_name]
      allow = name_allow_action(name)
    end
  end

  # filter on class name
  class ClassFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options[:class_rules] || {}
    end

    def allow_action(msg, context)
      name = context[:class_name]
      # puts "class_name: #{name}"
      allow = name_allow_action(name)
    end
  end


  # filter on method
  class MethodFilter < BaseFilter
    def initialize(options)
      super(options)   
      # puts "Method filter options: #{options.inspect}" 
      # puts "use :method_rules or :method_filter"  
      @rules = options[:method_rules] || options[:method_filter] || {}
    end

    def allow_action(msg, context)
      name = context[:method_name]
      # puts "allow name?: #{name}"
      allow = name_allow_action(name)
    end
  end
  
  # filter on instance variables
  class InstanceVarFilter < BaseFilter
    attr_accessor :var_name
        
    def initialize(options)
      super(options)    
      # puts "create inst.var filter: #{options.inspect}"  
      @rules = options[:var_rules] || {}
      @var_name = options[:var_name]
    end

    def allow_action(msg, context)
      # puts "InstanceVarFilter.allow_action"
      obj = context[:self]
      # puts "var_name: #{var_name}"
      if var_name.kind_of?(Symbol) || var_name.kind_of?(String)
        value = obj.instance_variable_get("@#{var_name}")      
        # puts "value: #{value}"
        return name_allow_action(value)
      end
      :yield
    end    
  end  
end
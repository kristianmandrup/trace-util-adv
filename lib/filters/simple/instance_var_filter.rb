module Tracing
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
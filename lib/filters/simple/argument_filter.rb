module Tracing
  # filter on instance variables
  class ArgumentFilter < BaseFilter
    attr_accessor :var_name
        
    def initialize(options)
      super(options)    
      @rules = options[:arg_rules] || options[:args_filter] || {}
      @var_name = options[:arg_name]
    end

    def allow_action(msg, context)
      puts "AMF"
      obj = context[:args]
      if var_name.kind_of?(Symbol) || var_name.kind_of?(String)
        key = var_name.to_sym
        if obj.has_key? key
          value = obj[key]      
          return name_allow_action(value)
        end
      end
      :yield
    end    
  end  
end
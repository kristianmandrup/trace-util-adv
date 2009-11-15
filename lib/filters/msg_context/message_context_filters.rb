# various alternative ways to provide include/exclude filters

# interface class
module Tracing
  class MsgContextFilter
    def initialize(options)
      @options = options
    end
  
    def name_allow_action(msg, context)
      return :include
    end
  end

  # example of specific filter on instance variable
  class InstanceVarRangeFilter < MsgContextFilter  
    def name_allow_action(msg, context)
      obj = context[:self]    
      var = obj.instance_variable_get @options[:var]
      return :include if @options[:range].include?(var)    
      return :yield
    end
  end
end
  
# custom filter
my_msg_filter = Tracing::InstanceVarRangeFilter.new({:range => 0..10, :var => :rating})

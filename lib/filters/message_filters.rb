# various alternative ways to provide include/exclude filters

# interface class
module Tracing
  class MsgFilter
    def initialize(options)
      @options = options
    end
  
    def name_allow_action(msg, context)
      return :include
    end
  end

  # example of specific filter on instance variable
  class RangeFilter < MsgFilter  
    def name_allow_action(msg, context)
      obj = context[:self]    
      var = obj.instance_variable_get @options[:var]
      return :include if @options[:range].include?(var)    
      return :yield
    end
  end

  # interface (abstract class)
  # instances of this form can be used as filters inside include/exclude lists
  class NameFilter 
    # return boolean
    def allow?(name)
      true
    end
  end
end
  
# custom filter
my_msg_filter = Tracing::RangeFilter.new({:range => 0..10, :var => :rating})

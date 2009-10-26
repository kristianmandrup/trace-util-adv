# various alternative ways to provide include/exclude filters

# interface class
module Tracing
  class MsgFilter
    def initialize(options)
      @options = options
    end
  
    def allow?(msg, context)
      true
    end
  end

  # example of specific filter on instance variable
  class RangeFilter < MsgFilter  
    def allow?(msg, context)
      obj = context[:self]    
      var = obj.instance_variable_get @options[:var]
      return @options[:range].include?(var)    
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

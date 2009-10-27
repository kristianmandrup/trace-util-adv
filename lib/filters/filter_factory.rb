# convenience methods to create and operate on filters, fx merge filters into composites, extract filters from composites etc

module Tracing::Filter

  def create_class_filter(symbol, names)
    case symbol
      when
        :iclass_filter 
          {:class_filter => {:include => names }}
      when
        :xclass_filter 
          {:class_filter => {:exclude => names }}      
      else
        raise Exception, "Unknown symbol for method filter creation"
    end  
  end

  
  def try_create_filter(name_hash)
      [:module_filter, :class_filter, :method_filter].each do |symbol|
        res = name_hash.try_create_filter(symbol)      
        return res if res
      end
      nil
  end
      
end
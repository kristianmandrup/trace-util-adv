# convenience methods to create and operate on filters, fx merge filters into composites, extract filters from composites etc

module Tracing::Filter
  
  def self.create_filter(name_hash)
    # puts "TRY create_filter: " + name_hash.inspect
      [:module_filter, :class_filter, :method_filter, :vars_filter].each do |symbol|
        # puts "symbol:" + symbol.to_s
        res = name_hash.try_create_filter_hash symbol
        # puts "Filter created:" + res.inspect     
        return res if res
      end
      # puts "no filter could be created :("
      nil
  end
      
end
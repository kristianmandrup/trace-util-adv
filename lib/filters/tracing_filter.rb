module Tracing
  module Filter
    # enable registration of filters
    module Registration
      attr_accessor :filters
      
      def create_filters(filters)
        if filters.kind_of?(Array)
          filters.flatten!
          new_filters = filters.collect do |f|
            if f.kind_of? Hash
              Tracing::BaseFilter.create_filter(f)
            elsif f.kind_of? Tracing::BaseFilter
              f
            end
          end  
          new_filters        
        elsif filters.kind_of? Hash
          Tracing::BaseFilter.create_filter(filters)
        else
          filters
        end        
      end
      
      def register_filters(filters)
        @filters ||= []      
        @filters.add(create_filters(filters))
      end

      def unregister_filters(filters)
        @filters.delete(filters)
      end

    end
    
    # enable execution of filters
    module Exec
      def filters_allow?(msg, context)
        @filters ||= Tracing::TraceExt.filters
        @filters.each do |_filter|
          # apply filter
          if _filter 
            res = _filter.allow?(msg, context)
            return false if res == :exclude
            return true if res == :include
          end
        end
        return true
      end
    end
  end
end


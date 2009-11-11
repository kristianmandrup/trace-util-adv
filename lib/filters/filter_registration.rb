module Tracing
  module Filter
    # enable registration of filters
    module Registration
      attr_accessor :filters
      
      def create_filters(reg_filters)
        if reg_filters.kind_of?(Array)
          reg_filters.flatten!
          new_filters = reg_filters.collect do |f|
            if f.kind_of? Hash
              Tracing::BaseFilter.create_filter(f)
            elsif f.kind_of? Tracing::BaseFilter
              f
            end
          end  
          new_filters        
        elsif filters.kind_of? Hash
          Tracing::BaseFilter.create_filter(reg_filters)
        else
          reg_filters
        end        
      end
      
      def register_filters(reg_filters)
        @filters ||= []      
        @filters.add(reg_filters.filters)
      end
      
      def _register_filters(reg_filters)
        @filters ||= []      
        
        # puts "Register filters, using: #{reg_filters.inspect}"                  
        new_filters = create_filters(reg_filters)
        
        # puts "New filters to register: #{new_filters.inspect}"          
        return if !new_filters
        if new_filters
          new_filters.compact! 
          return if !(new_filters.size > 0)
          # puts "DO register filters: #{new_filters.inspect}"          
          @filters << new_filters.flatten!
          # puts "Filters after reg: " + @filters.inspect
        end
      end

      def unregister_filters(filters)
        filters.delete(filters)
      end

    end
  end
end
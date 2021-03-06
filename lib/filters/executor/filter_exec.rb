module Tracing
  module Filter            
    # enable execution of filters
    class Executor
      attr_accessor :filters, :final_yield_action
            
      def initialize(options = {})
        @final_yield_action = options[:final_yield_action] || :exclude
        @filters ||= []
        _filters = options.filters
        # puts "filters exec: #{_filters.inspect}"
        @filters.add(_filters) if filters
      end      
      
      # determine if message and context should pass through filter chain
      # return: 
      # - true to allow
      # - false to disallow
      def filters_allow?(msg, context)
        # puts "method: filters_allow?"
                        
        # default allow return value
        allow = (final_yield_action == :exclude ? false : true)               
        
        puts "default allow: #{allow}"
        # puts "filters: #{@filters}"  
        
        return allow if @filters.blank?        
        
        # puts "iterate filters"
        @filters.each do |_filter|
          # puts "filter:" + _filter.inspect
          # apply filter
          if _filter 
            res = _filter.allow_action(msg, context)
            # puts "res: #{res}"  

            if (res == :include_and_yield)
              allow = true
            end

            if (res == :exclude_and_yield)
              allow = false
            end

            if (res == :include)
              # puts "included - break"
              allow = true
              break
            end
            
            if (res == :exclude) 
              # puts "excluded - break"              
              allow = false
              break
            end
            # puts "yielding..."
          else
            # puts "filter is null"
          end
        end
        # puts "filters_allow?: #{allow}"
        return allow
      end
    end
  end
end


module Tracing
  module Filter            
    module ExecUse
      # set to instance of Tracing::Filter:Exec
      attr_accessor :filter_executor
      
      def self.included(klass)
        @filter_executor ||= Tracing::Filter::Executor.new
      end
        
    end
  end
end
      
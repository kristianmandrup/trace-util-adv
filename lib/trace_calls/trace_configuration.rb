module Tracing
  class Configuration
    class << self 
      def apply(options)
        in_module = options[:module]
        classes_to_trace = options[:classes]
        classes_to_trace.each do |cls|
          eval "#{in_module}::#{cls}.class_eval { include Tracing::TraceCalls }"
        end            
      end
    end
    
    include Tracing::Filter::Registration
    include Tracing::ActionHandler::Registration
require 'filters/executor/filter_exec'

    attr_accessor :final_yield_action

    def initialize(options)      
      register_filters(options.filters)
      register_action_handlers(options.action_handlers)
      @final_yield_action = options.final_yield_action
    end
    
  end
end  


   


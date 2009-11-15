require 'extensions/include'
require 'appenders/include'
require "templates/include"
require 'output_handler/output_handler'
require 'action_handler/action_handler'
require 'filters/filter_use'
require "duration"

module Tracing
  module TraceExt
    include Tracing::Filter::Exec

    class << self
      # supports 
      # - Filter registration    
      # - ActionHandler registration
      include Tracing::Filter::Registration
      include Tracing::ActionHandler::Registration

      attr_accessor :final_yield_action

      def configure(options)
        # puts "Filters before config: " + Tracing::TraceExt.filters.inspect        
        
        register_filters(options[:filters])
        
        # puts "Filters after config: " + Tracing::TraceExt.filters.inspect        
        
        register_action_handlers(options[:action_handlers] || options)
        @final_yield_action = options[:final_yield] || :include
      end

    end

    def trace_method?(context)
      filters_allow?('', context)
    end

    def handle_before_call(context)
      exec_action_handlers('BEGIN' , context)
    end

    def handle_after_call(context)
      exec_action_handlers('END' , context)      
    end

    def exec_action_handlers(txt, context)
      _handlers = Tracing::TraceExt.action_handlers
      
      # puts "exec_action_handlers:" + _handlers.inspect       
      return if !_handlers || !_handlers.kind_of?(Array)
      # puts "each handler..."
      _handlers.each do |handler|
        handler.handle(txt, context)
      end
    end
  end
end

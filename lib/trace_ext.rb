require 'templates/trace_output_handler'
require 'trace_filters'
require 'action_handler'
require 'trace_appenders'

module Tracing
  module TraceExt
    # include Tracing::Filter::Registration
    include Tracing::Filter::Exec

    class << self
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

    def method_full_name(context)
      "#{context[:class_name]}.#{context[:method_name]}"
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

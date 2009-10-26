require 'templates/trace_output_handler'
require 'trace_filters'
require 'action_handler'
require 'trace_appenders'

module Tracing
  module TraceExt
    include Tracing::Filter::Registration
    include Tracing::Filter::Exec

    class << self
      include Tracing::Filter::Registration
      include Tracing::ActionHandler::Registration

      def configure(options)
        register_filters options[:filters]
        register_action_handlers options[:action_handlers] || options
      end

    end


    def method_full_name(context)
      "#{context[:class_name]}.#{context[:method_name]}"
    end

    def trace_method?(context)
      filters_allow?('', context)
    end

    def handle_before_call(context)
      # name = context[:method_name]
      # method_stack.push(name)
      action_handlers('BEGIN' , context)
    end

    def handle_after_call(context)
      # name = context[:method_name]
      # method_stack.push(name)
      action_handlers('END' , context)      
    end

    def action_handlers(txt, context)
      return if !TraceExt.action_handlers
      TraceExt.action_handlers.each do |handler|
        handler.handle(txt, context)
      end
    end
  end
end

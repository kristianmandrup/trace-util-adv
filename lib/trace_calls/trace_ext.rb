module Tracing
  module TraceExt
    include Tracing::FilterUse

    class << self
      attr_accessor :configuration

      def configure(configuration)
        @configuration ||= configuration if configuration.kind_of? Tracing::Configuration
      end

    end

    def trace_method?(context)
      # p filter_executor
      filter_executor.filters_allow?('', context) if filter_executor
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

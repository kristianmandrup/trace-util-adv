require 'filters/tracing_filter'
require 'trace_appenders'

module Tracing
  class ActionHandler
    include Tracing::Filter::Registration    
    include Tracing::Filter::Exec    
    include Tracing::Appender::Registration  

    attr_accessor :filters

    # enable registration of action handlers
    module Registration
      attr_accessor :action_handlers

      def action_handler_from_type(type, options)      
        if type.kind_of?(Symbol)
          type_sym = type.to_sym
          # use default mappings if no match found
          appender_class = appender_mappings[type_sym] || action_handler_mappings[:default]
          if appender_class
            appender_class.new(options)
          else
            # nil
            raise Exception, "No appender registered for this type: #{type}"
          end
        elsif appender.kind_of? Tracing::OutputTemplate::Trace
          appender
        else
          nil
        end          
      end

      def create_action_handlers(reg_action_handlers)
        if reg_action_handlers.kind_of? Array
          reg_action_handlers.flatten!
          new_action_handlers = reg_action_handlers.collect do |f|
            create_action_handler(f)
          end  
          new_action_handlers                  
        elsif reg_action_handlers.kind_of?(Symbol) || reg_action_handlers.kind_of?(Hash)
          create_action_handler(reg_action_handlers)
        else
          reg_action_handlers
        end        
      end      
      
      def create_action_handler(options)
        if options.kind_of? Tracing::ActionHandler
          options
        elsif options.kind_of? Hash
          Tracing::ActionHandler.new(options)
        elsif options.kind_of?(Symbol) || options.kind_of?(String)
          type = options.to_sym
          Tracing::Appender.appender_from_type(type, options)
        else
          nil
        end          
      end      

      # TODO: add convenience way to register action handlers using symbols!
      def register_action_handlers(reg_action_handlers)
        @action_handlers ||= []
        new_action_handlers = create_action_handlers(reg_action_handlers)
        raise Exception, "No action handlers" if !new_action_handlers
        @action_handlers << new_action_handlers
      end
    end
  
    # register filters and appenders
    def initialize(init_options)
      register_filters(init_options[:filters])
      register_appenders(init_options[:appenders] || init_options)
    end 

    # action for tracelogs that pass the filters
    # by default send to all appenders for further processing!
    def handle_allow(txt, context)
      appenders.each do |appender|
        appender.handle(txt, context)
      end
    end

    # action for tracelogs that DO NOT pass the filters
    def handle_not_allow(txt, context)
    end

    # handle tracelogs by applying filters and action handler methods
    def handle(txt, context)
      if filters_allow?(txt, context)
        # puts "handle_allow: " + context[:method_name]
        handle_allow(txt, context)
      else
        # puts "handle_not_allow: " + context[:method_name]        
        handle_not_allow(txt, context)
      end
    end
  end # class
end # module
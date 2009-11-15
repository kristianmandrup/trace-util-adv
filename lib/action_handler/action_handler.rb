Dir.glob(File.join(File.dirname(__FILE__), '**/*.rb')).each {|f| require f }

module Tracing
  class ActionHandler
    # supports:
    # - Filter registration and execution    
    # - Appender registration
    include Tracing::FilterUse
    include Tracing::Appender::Registration  
  
    # register filters and appenders
    def initialize(init_options)
      register_filters(init_options.filters)
      register_appenders(init_options.appenders)
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
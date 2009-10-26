module Tracing
  # base appender (abstract)
  class BaseAppender
    include Tracing::Filter::Registration  
    include Tracing::Filter::Exec    

    attr_accessor :options
    attr_reader :tracer
    
    class << self
      attr_accessor :tracers

      def default_tracers
        {
          :string => Tracing::OutputTemplate::StringTrace, 
          :xml => Tracing::OutputTemplate::XmlTrace,
          :html => Tracing::OutputTemplate::HtmlTrace,          
          :default => Tracing::OutputTemplate::StringTrace
        }
      end

      def register_tracers(tracers = nil)
        @tracers ||= default_tracers
        @tracers = @tracers.merge!(tracers || {})
      end
      
      def create_tracer(tracer)
        tracers ||= register_tracers
        if tracer.kind_of?(Symbol) || tracer.kind_of?(String)
          tracer_class = tracers[tracer.to_sym] || tracers[:default]
          tracer_class.new
        elsif tracer.kind_of? Tracing::OutputTemplate::Trace
          tracer
        else
          nil
        end
      end      
    end

    def initialize(init_options = nil)          
      return if !init_options
      if init_options.kind_of? Hash
        @options = init_options[:options] || init_options
        register_filters(init_options[:filters])
        tracer = @options[:tracer] if @options
        return if !tracer

        tracer = self.class.create_tracer(tracer)      
        @tracer = tracer         
      elsif init_options.kind_of? Symbol
        self.class.register_tracers
        tracer = self.class.tracers[init_options]
        return if !tracer

        tracer = self.class.create_tracer(tracer)      
        @tracer = tracer                 
      else
        raise Exception, "Appender must be initialized with Hash"
      end
    end 
  
    # default action handler depending on filters result 
    def handle(txt, context)
      if filters_allow?(txt, context)
        allow_append(txt, context)
      else
        not_allow_append(txt, context)
      end
    end
  
    def allow_append(txt, context)  
          
    end

    def not_allow_append(txt, context)
    end

    def time_limit
      options[:time_limit] || 1.minute    
    end
  end
end  
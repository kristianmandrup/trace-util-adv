module Tracing 
  class StreamAppender < BaseAppender  
    attr_accessor :stream

    def configure_stream(options)
      @stream = $stdout            
      if options
        case options[:stream]
          when :error
            @stream = $stderr      
        end
      end
    end

    def initialize(init_options)
      @tracer = Tracing::OutputTemplate::StringTrace.new      
      super(init_options)
      configure_stream(init_options)                        
    end
  
    # perform append
    def allow_append(txt, context)
      # check if BEGIN or END
      if txt.include?('BEGIN')
        txt = tracer.handle_before_call(context)
      elsif txt.include?('END')
        txt = tracer.handle_after_call(context)
      end
      
      stream.puts txt
    end

    # silently ignore
    def not_allow_append(lines, context)
    end
  end
end
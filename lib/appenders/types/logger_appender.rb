require 'logger'

# append log to STDOUT Logger
module Tracing 
  class LoggerAppender < BaseAppender  
    attr_reader :logger

    def stream(options)
      if options
        case options[:stream]
          when :error
            STDERR      
          else
            STDOUT
        end
      else
        STDOUT
      end
    end

    def log_lv(options)
      if options
        case options[:log_level]
          when :info
            Logger::INFO      
          when :warning
            Logger::WARNING      
          when :fatal
            Logger::FATAL      
          else
            Logger::DEBUG
        end
      else
        Logger::DEBUG
      end
    end    

    def initialize(init_options)
      @tracer = Tracing::OutputTemplate::StringTrace.new      
      super(init_options)
                  
      if init_options.kind_of? Hash            
        logger_options = init_options[:logger] if init_options
      end
      log_stream = stream(logger_options)
      log_level = log_lv(logger_options)
      
      @logger ||= Logger.new(log_stream)
      @logger.level ||= log_level           
    end

    def log_debug(txt)
      logger.debug txt
    end
  
    def log_info(txt)
      logger.info txt
    end
  
    # perform append
    def allow_append(txt, context)
      # check if BEGIN or END
      if txt.include?('BEGIN')
        txt = tracer.handle_before_call(context)
      elsif txt.include?('END')
        txt = tracer.handle_after_call(context)
      end
      
      if txt.include?('INFO')
        log_info txt
      elsif txt.include?('WARNING')
          log_warning txt
      elsif txt.include?('ERROR')
          log_error txt      
      else
        log_debug txt
      end
    end

    # silently ignore
    def not_allow_append(lines, context)
    end
  end
end
module Tracing
  module Appender
    
    class << self

      # array of Appender instances
      attr_accessor :appender_mappings

      def register_default_mappings
        @appender_mappings ||= {}
        @appender_mappings.merge!(AppenderMappings.defaults)
      end

      def register_appender_mappings(_appender_mappings)
        appenders_mappings ||= {}
        appenders_mappings.merge!(_appender_mappings)
      end
      
      def unregister_appender_mappings(hash)
        default_appender_mappings.reject!{|key, value| hash.include? key}
      end      
      

      def create_appenders(appenders)
        register_default_mappings if !appender_mappings
        if appenders.kind_of? Array
          appenders.flatten!
          new_appenders = appenders.collect do |f|
              Tracing::Appender.create_appender(f)
          end  
          new_appenders                  
        elsif appenders.kind_of?(Symbol) || appenders.kind_of?(Hash)
          Tracing::Appender.create_appender(appenders)
        else
          appenders
        end        
      end

      def appender_options_type(options)
        options[:type] || options[:appender]
      end

      def appender_type(options)
        if options.kind_of? Hash
          appender_options_type(options)
        elsif options.kind_of?(Symbol) || options.kind_of?(String)
          options.to_sym
        end
      end
      
      def appender_from_type(type, options)  
        register_default_mappings if !appender_mappings
        if type.kind_of?(Symbol)
          type_sym = type.to_sym
          # use default mappings if no match found
          appender_class = appender_mappings[type_sym] || appender_mappings[:default]
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
      
      # 
      def create_appender(options)
        appender_mappings ||= {}
        type = appender_type(options)
        if type
          appender_from_type(type, options)
        elsif options.kind_of? Tracing::BaseAppender
          options
        else
          nil
        end          
      end        
    end # class
    
  end   
end

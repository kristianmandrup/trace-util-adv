module Tracing
  module Appender  
  
    # enable registration of appenders
    module Registration
      attr_accessor :appenders

      def register_appenders(appenders)
        @appenders ||= []      
        new_appenders = Tracing::Appender.create_appenders(appenders)
        @appenders.add(new_appenders) if new_appenders        
      end
      
    end # registration
  end
end
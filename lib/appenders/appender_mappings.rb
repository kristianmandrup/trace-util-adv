module AppenderMappings    
  # used to help construct/register Appender instances using convenience symbols
  def self.defaults
    {
      :logger => Tracing::LoggerAppender,
      :stream => Tracing::StreamAppender,           
      :xml => Tracing::XmlAppender,
      :html => Tracing::HtmlAppender,          
      :template => Tracing::TemplateLogAppender,          
      :default => Tracing::StreamAppender
    }
  end
end

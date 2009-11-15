module TemplateMappings  
  def self.defaults
    {
      :string => Tracing::OutputTemplate::StringTrace, 
      :xml => Tracing::OutputTemplate::XmlTrace,
      :html => Tracing::OutputTemplate::HtmlTrace,          
      :default => Tracing::OutputTemplate::StringTrace
    }
  end
end
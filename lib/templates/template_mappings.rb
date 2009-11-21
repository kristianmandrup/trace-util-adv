module TemplateMappings  
  def self.defaults
    {
      :string => Tracing::StringTemplate, 
      :xml => Tracing::XmlTemplate,
      :html => Tracing::HtmlTemplate,          
      :default => Tracing::StringTemplate
    }
  end
end
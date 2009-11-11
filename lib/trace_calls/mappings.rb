require 'appenders/trace_appenders'
require 'templates/output_templates'
require 'filters/trace_filters'

module Mappings
  
  def self.filter_rule_mappings
    {
      :module_rules => :module_filter,
      :class_rules => :class_filter,
      :method_rules => :method_filter,        
      :var_rules => :vars_filter,        
      :modules => :composite_module_filter,
      :classes => :composite_class_filter,
      :vars => :composite_vars_filter
    }
  end

  def self.convenience_map
    {
     :module => :module_filter,
     :class => :class_filter,
     :method => :method_filter,
     :variable => :vars_filter,
    }
  end


  def self.default_filters
    {
     :module_filter => Tracing::ModuleFilter,
     :class_filter  => Tracing::ClassFilter,
     :method_filter => Tracing::MethodFilter,
     :vars_filter => Tracing::InstanceVarFilter,
     :composite_module_filter => Tracing::CompositeModuleFilter,
     :composite_class_filter => Tracing::CompositeClassFilter,
     :composite_vars_filter => Tracing::CompositeInstanceVarFilter
    }
  end  
  
  # used to help construct/register Appender instances using convenience symbols
  def self.default_appender_mappings
    {
      :logger => Tracing::LoggerAppender,
      :stream => Tracing::StreamAppender,           
      :xml => Tracing::XmlAppender,
      :html => Tracing::HtmlAppender,          
      :template => Tracing::TemplateLogAppender,          
      :default => Tracing::StreamAppender
    }
  end
  
  def self.default_tracer_mappings
    {
      :string => Tracing::OutputTemplate::StringTrace, 
      :xml => Tracing::OutputTemplate::XmlTrace,
      :html => Tracing::OutputTemplate::HtmlTrace,          
      :default => Tracing::OutputTemplate::StringTrace
    }
  end
  
  
  def self.rule_symbol_mappings
    {
      :i => :include,
      :x => :exclude,
      :iy => :include_and_yield,
      :xy => :exclude_and_yield      
    }
  end  
end  

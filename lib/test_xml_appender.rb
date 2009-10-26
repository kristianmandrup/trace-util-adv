require "core_extensions"
require "trace_calls"
require "output_templates"
require "sample_filters"
require "rubygems"
require "duration"
require "test/unit"
 
class TestFilter < Test::Unit::TestCase

  attr_reader :ah1, :filters

  def setup
    # Tracing::Appender.register_default_mappings    
    
    # test all the ways an appender can be initialized!
    @ah1 = Tracing::XmlAppender.new(:tracer => :xml, :to_file => 'log_files/xml/traced.xml')      
  end

  def teardown
    ## Nothing really
  end
    
  def method_full_name(context)
    "#{context[:class_name]}.#{context[:method_name]}"
  end
    
  def test_filter
    cls_name = "Alpha::Beta::Gamma"
    name = "my_method"
    my_instance_variables = {:template_path => 'taglibs/rapid_core.dryml'}
    args = {:a => 7}
    @context = {
      :modules => cls_name.modules,
      :class_name => cls_name.class_name,
      :full_class_name => cls_name,
      :method_name => name,
      :args => args,
      :block => false,
      :vars => my_instance_variables # to carry @template_path etc.
    }    
    @context[:method_full_name] = method_full_name(@context)
    
    @ah1.allow_append("BEGIN #{name}", @context)

    name = "my_other_method"

    @context[:method_name] = name
    @context[:method_full_name] = method_full_name(@context)

    @ah1.allow_append("BEGIN #{name}", @context)        
    
    @context[:result] = "32"
    @ah1.allow_append("END #{name}", @context)    

    name = "my_method"
    @context[:method_name] = name    
    @context[:method_full_name] = method_full_name(@context)    
    
    @context[:result] = "27"
    @ah1.allow_append("END #{name}", @context)    
  end
  
  
end


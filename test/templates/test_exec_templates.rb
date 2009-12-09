require "include"

class TestExecuteTemplates < Test::Unit::TestCase

  def setup
    @html_template = {:template => :html}.template
    assert_equal @html_template.class, Tracing::HtmlTemplate, "Should result in HtmlTemplate"    

    @xml_template = {:template => :xml}.template
    assert_equal @xml_template.class, Tracing::XmlTemplate, "Should result in XmlTemplate"    

    @string_template = {:template => :string}.template
    assert_equal @string_template.class, Tracing::StringTemplate, "Should result in StringTemplate"    
    
    @context = {:class_name => "Hobo::Dryml", :method_name => "build_a"}.context
  end
  
  def test_exec_html_template
    result = @html_template.handle_before_call(@context)    
    assert result
  end

  def test_exec_xml_template
    result = @xml_template.handle_before_call(@context)    
    assert result
  end

  def test_exec_string_template
    result = @string_template.handle_before_call(@context)    
    assert result
  end

end
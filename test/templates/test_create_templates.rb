require "include"


class TestCreateTemplates < Test::Unit::TestCase

  def test_create_string_template
    rule = {:template => :string}
    result = rule.template
    assert_equal result.class, Tracing::StringTemplate, "Should result in StringTemplate"    
  end

  def test_create_xml_template
    xml_tracer = {:type => :xml, :to_file => 'log_files/xml/traced.xml'}.template
    assert_equal Tracing::XmlTemplate, xml_tracer.class, "Should create instance of XmlTemplate"
  end

  def test_create_html_template
    html_tracer = {:type => :html, :default_path => 'log_files/html'}.template
    assert_equal Tracing::HtmlTemplate, html_tracer.class, "Should create instance of HtmlTemplate"
  end

end




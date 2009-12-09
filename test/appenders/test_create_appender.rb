require "include"


class TestCreateAppender < Test::Unit::TestCase

  def test_create_xml_appender
    xml_appender = {:type => :xml, :to_file => 'log_files/xml/traced.xml'}.appender
    assert_equal Tracing::XmlAppender, xml_appender.class, "Should create instance of XmlAppender"    
  end

end

require "include"


class TestCreateAppender < Test::Unit::TestCase

  def test_create_xml_appender
    appender = {:type => :xml, :to_file => 'log_files/xml/traced.xml'}.appender
    assert_equal Tracing::XmlAppender, appender.class, "Should create instance of XmlAppender"    
  end

  def test_create_html_appender
    appender = {:type => :html, :to_file => 'log_files/html/traced.html'}.appender
    assert_equal Tracing::HtmlAppender, appender.class, "Should create instance of HtmlAppender"    
  end

  def test_create_string_appender
    appender = {:type => :stream}.appender
    assert_equal Tracing::StreamAppender, appender.class, "Should create instance of StreamAppender"    
  end


end

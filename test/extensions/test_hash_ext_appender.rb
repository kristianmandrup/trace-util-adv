require "include"

class TestHashExtensions < Test::Unit::TestCase

  def test_appenders
    config = {:appenders => []}
    result = config.appenders
    assert_equal true, result.blank?, "Should result in empty appender list"    

    config = {:appenders => :html}
    result = config.appenders
    assert_equal result.class, Tracing::HtmlAppender, "Should result in empty appender list"    

    config = {:appenders => [:xml, :html]}
    result = config.appenders
    assert_equal Tracing::XmlAppender, result[0].class, "Should result in xml appender"        
    assert_equal Tracing::HtmlAppender, result[1].class, "Should also result in html appender"    
  end

  def test_appender
    result = {:appenders => :xml}.appender    
    assert_equal Tracing::XmlAppender, result.class, "Should xml appender"    

    result = {:appender => :html}.appender    
    assert_equal Tracing::HtmlAppender, result.class, "Should result in html appender"    

    result = {:type => :xml}.appender    
    assert_equal Tracing::XmlAppender, result.class, "Should result in xml appender"      
  end

end
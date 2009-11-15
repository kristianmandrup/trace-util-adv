require 'extensions/core_extensions'
require "test/unit"


class TestAppenderTracers < Test::Unit::TestCase

  def test_exec_xml_tracer
    xml_tracer = {:type => :xml, :to_file => 'log_files/xml/traced.xml'}.tracer
    assert_equal Tracing::XmlAppender, xml_tracer.class, "Should create instance of XmlTracer"
    
    xml_tracer.trace('hello world')    
  end

  def test_exec_html_tracer
    html_tracer = {:type => :html, :default_path => 'log_files/html'}.tracer
    assert_equal Tracing::HtmlAppender, html_tracer.class, "Should create instance of HtmlTracer"
     
    html_tracer.trace('hello world')
  end

  def test_exec_log_tracer
    log_tracer = {:type => :log, :default_path => 'log_files'}.tracer
    assert_equal Tracing::LoggerAppender, log_tracer.class, "Should create instance of LogTracer"
    
    log_tracer.trace('hello world')
  end

  def test_exec_log_tracer
    appender = {:type => :stream, :stream => :STDOUT}.tracer
    assert_equal Tracing::StreamAppender, log_tracer.class, "Should create instance of StreamTracer"
    
    stream_tracer.trace('hello world')
  end

  def test_create_appenders
    config = {:appenders => []}
    result = config.appenders
    assert_equal result.blank?, true, "Should result in empty appender list"    

    config = {:appenders => :html}
    result = config.appenders
    assert_equal result.class, Tracing::HtmlAppender, "Should result in empty appender list"    

    config = {:appenders => [:xml, :html]}
    result = config.appenders
    assert_equal Tracing::XmlAppender, result[0].class, "Should result in xml appender"        
    assert_equal Tracing::HtmlAppender, result[1].class, "Should also result in html appender"    
  end
end

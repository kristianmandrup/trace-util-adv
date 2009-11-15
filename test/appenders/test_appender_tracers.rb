require 'extensions/core_extensions'
require 'filters/base_filters'
require 'rules/hash_rule_extensions'
require "test/unit"


class TestAppenderTracers < Test::Unit::TestCase

  def setup
    # Trace filters
    im_filter_1 = {:i_method_filter => "a,b"}
    xym_class_1 = {:xy_class_filter => "C,D"}
    @filters = [im_filter_1, xym_class_1]

    @app_filter_1 = {:x_class_filter => "Dryml"}
    @app_filter_2 = {:i_class_filter => "Template"}

    @xml_tracer = {:type => :xml, :to_file => 'log_files/xml/traced.xml'}.tracer
    @html_tracer = {:type => :html, :default_path => 'log_files/html/'}.tracer
    @log_tracer = {:type => :log}.tracer
    @stream_tracer = {:type => :stream}.tracer
  end  
  

  def test_appender_register_tracer
    # Trace configuration
    appender_1 = {:tracer => @xml_tracer}.appender
    assert_equal Tracing::XmlAppender, appender_1.class, "Should create instance of XmlAppender"

    appender_2 = {:tracer => @html_tracer}.appender
    assert_equal Tracing::HtmlAppender, appender_2.class, "Should create instance of HtmlAppender"

    appender_3 = {:tracer => @log_tracer}.appender
    assert_equal Tracing::HtmlAppender, appender_3.class, "Should create instance of LogAppender"

    appender_4 = {:tracer => @stream_tracer}.appender
    assert_equal Tracing::StreamAppender, appender_4.class, "Should create instance of Streamppender"
  end


  def test_appender_register_tracer_and_filters
    # Trace configuration
    appender_1 = {:tracer => @xml_tracer, :filters => @app_filter_1}.appender
    assert_equal Tracing::XmlAppender, appender_1.class, "Should create instance of XmlAppender"

    appender_2 = {:tracer => @html_tracer, :filters => @app_filter_1}.appender
    assert_equal Tracing::HtmlAppender, appender_2.class, "Should create instance of HtmlAppender"

    appender_3 = {:tracer => @log_tracer, :filters => @app_filter_1}.appender
    assert_equal Tracing::HtmlAppender, appender_3.class, "Should create instance of LogAppender"

    appender_4 = {:tracer => @stream_tracer, :filters => @app_filter_1}.appender
    assert_equal Tracing::StreamAppender, appender_4.class, "Should create instance of Streamppender"
  end

end

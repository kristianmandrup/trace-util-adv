require "include"


class TestAppenderTemplates < Test::Unit::TestCase

  def setup
    # Trace filters
    im_filter_1 = {:i_method_filter => "a,b"}
    xym_class_1 = {:xy_class_filter => "C,D"}
    @filters = [im_filter_1, xym_class_1]

    @app_filter_1 = {:x_class_filter => "Dryml"}
    @app_filter_2 = {:i_class_filter => "Template"}

    @xml_tracer = {:type => :xml, :to_file => 'log_files/xml/traced.xml'}.template
    
    # puts "xmltracer: #{@xml_tracer.inspect}"
    
    # @html_tracer = {:type => :html, :default_path => 'log_files/html/'}.template
    # @log_tracer = {:type => :log}.template
    # @stream_tracer = {:type => :stream}.template
  end  
  

  def test_appender_register_tracer
    # Trace configuration    
    
    appender_1 = {:appender => :xml, :template => @xml_tracer}.appender
    puts "Appender 1: #{appender_1}"
    assert_equal Tracing::XmlAppender, appender_1.class, "Should create instance of XmlAppender"

    # appender_2 = {:template => @html_tracer}.appender
    # assert_equal Tracing::HtmlAppender, appender_2.class, "Should create instance of HtmlAppender"
    # 
    # appender_3 = {:template => @log_tracer}.appender
    # assert_equal Tracing::HtmlAppender, appender_3.class, "Should create instance of LogAppender"
    # 
    # appender_4 = {:template => @stream_tracer}.appender
    # assert_equal Tracing::StreamAppender, appender_4.class, "Should create instance of StreamAppender"
  end


  def test_appender_register_tracer_and_filters
    # Trace configuration
    # appender_1 = {:template => @xml_tracer, :filters => @app_filter_1}.appender
    # assert_equal Tracing::XmlAppender, appender_1.class, "Should create instance of XmlAppender"

    # appender_2 = {:template => @html_tracer, :filters => @app_filter_1}.appender
    # assert_equal Tracing::HtmlAppender, appender_2.class, "Should create instance of HtmlAppender"
    # 
    # appender_3 = {:template => @log_tracer, :filters => @app_filter_1}.appender
    # assert_equal Tracing::HtmlAppender, appender_3.class, "Should create instance of LogAppender"
    # 
    # appender_4 = {:template => @stream_tracer, :filters => @app_filter_1}.appender
    # assert_equal Tracing::StreamAppender, appender_4.class, "Should create instance of Streamppender"
  end

end

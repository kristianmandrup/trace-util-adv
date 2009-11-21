

# def test_create_xml_tracer
#   xml_tracer = {:type => :xml, :to_file => 'log_files/xml/traced.xml'}.template
#   assert_equal Tracing::XmlTemplate, xml_tracer.class, "Should create instance of XmlTemplate"
# end
# 
# def test_create_html_tracer
#   html_tracer = {:type => :html, :default_path => 'log_files/html'}.template
#   assert_equal Tracing::HtmlTemplate, html_tracer.class, "Should create instance of HtmlTemplate"
# end
# 
# def test_create_log_tracer
#   log_tracer = {:type => :log, :default_path => 'log_files'}.template
#   assert_equal Tracing::LogTemplate, log_tracer.class, "Should create instance of LogTemplate"
# end
# 
# def test_create_log_tracer
#   stream_tracer = {:type => :stream, :stream => :STDOUT}.template
#   assert_equal Tracing::StreamTemplate, log_tracer.class, "Should create instance of StreamTemplate"
# end

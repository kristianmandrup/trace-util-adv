require 'extensions/core_extensions'
require 'filters/base_filters'
require 'rules/hash_rule_extensions'
require "test/unit"


class TestCreateTracers < Test::Unit::TestCase

  def test_tracer
    rule = {:tracer => :html}
    result = rule.tracer
    assert_equal result.class, Tracing::OutputTemplate::HtmlTrace, "Should result in HtmlTrace"    

    rule = {:tracer => :xml}
    result = rule.tracer
    assert_equal result.class, Tracing::OutputTemplate::XmlTrace, "Should result in XmlTrace"    

    rule = {:tracer => :string}
    result = rule.tracer
    assert_equal result.class, Tracing::OutputTemplate::StringTrace, "Should result in StringTrace"    
  end

  def test_create_xml_tracer
    xml_tracer = {:type => :xml, :to_file => 'log_files/xml/traced.xml'}.tracer
    assert_equal Tracing::XmlTracer, xml_tracer.class, "Should create instance of XmlTracer"
  end

  def test_create_html_tracer
    html_tracer = {:type => :html, :default_path => 'log_files/html'}.tracer
    assert_equal Tracing::HtmlTracer, html_tracer.class, "Should create instance of HtmlTracer"
  end

  def test_create_log_tracer
    log_tracer = {:type => :log, :default_path => 'log_files'}.tracer
    assert_equal Tracing::LogTracer, log_tracer.class, "Should create instance of LogTracer"
  end

  def test_create_log_tracer
    stream_tracer = {:type => :stream, :stream => :STDOUT}.tracer
    assert_equal Tracing::StreamTracer, log_tracer.class, "Should create instance of StreamTracer"
  end

end




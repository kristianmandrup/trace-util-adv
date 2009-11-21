require 'include'

class TestSymbolExtensions < Test::Unit::TestCase

  def setup
  end

  def teardown
    ## Nothing really
  end
            
  def test_prefix
    prefixed_symbol = :test.prefix(:xy)    
    assert_equal prefixed_symbol, :xy_test, "Should result in :xy_test"
  end
  
  def test_trace_class
    result = :xml.trace_class
    assert_equal result, Tracing::XmlTemplate, ":xml Should result in XmlTrace"            
  end
  
  def appender_class
    result = :xml.trace_class
    assert_equal result, Tracing::XmlAppender, ":xml Should result in XmlTrace"            
  end
  
  def test_rule
    result = :i.rule
    assert_equal result, :include, ":i Should result in :include"
  end

  
end

require "core_extensions"
require "trace_calls"
require "sample_filters"
require "rubygems"
require "duration"
require "test/unit"
 
class TestFilter < Test::Unit::TestCase

  attr_reader :ah1, :filters

  def setup
    # Tracing::Appender.register_default_mappings    
    
    # test all the ways an appender can be initialized!
    @ah1 = Tracing::LoggerAppender.new(:tracer => :html)      
  end

  def teardown
    ## Nothing really
  end
    
  def test_filter
    puts @ah1.inspect
  end
  
  
end


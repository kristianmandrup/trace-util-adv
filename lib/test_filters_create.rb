require "core_extensions"
require "trace_calls"
require "sample_filters"
require "rubygems"
require "duration"
require "test/unit"
 
class TestFilter < Test::Unit::TestCase

  def setup
    @ah1 = Tracing::ActionHandler.new(:filters => [Module_filter_A, Class_filter_A])      
    @ah1 = Tracing::ActionHandler.new(:filters => Class_filter_A)      
  end

  def teardown
    ## Nothing really
  end
    
  def test_filter
    puts @ah1.inspect
    
    # Tracing::TraceExt.configure(:filters => Class_filter_A)    
    # Tracing::TraceExt.configure(:filters => [Module_filter_A, Class_filter_A])        
  end
  
  
end


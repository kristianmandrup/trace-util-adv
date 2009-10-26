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
    @file = 'test.txt'
    
    # test all the ways an appender can be initialized!
    @file_appender = Tracing::FileAppender.new({:overwrite => true, :to_file => @file})
  end

  def teardown
    ## Nothing really
  end
    
  def test_filter
    @file_appender.write_file(@file, "Hello World")
    marker_txt = 'World'
    @file_appender.insert_into_file(@file, 'My old ', marker_txt)
  end
  
  
end


require "core_extensions"
require "trace_calls"
require "sample_filters"
require "rubygems"
require "duration"
require "test/unit"
 
class TestFilter < Test::Unit::TestCase

  attr_reader :ah1, :filters

  def setup
    # tla1 = Tracing::TemplateLogAppender.new(:options => {:overwrite => false, :time_limit => 2.minutes}, :tracer => :string)      
    # action handler is configured with a set of filters and a set of appenders
    # the appenders are called in turn if log statement passes all filters!
    # @ah1 = Tracing::ActionHandler.new(:filters => @filters = Module_filter_A)  

    appender_options = {:options => {:overwrite => false, :time_limit => 2.minutes}, :type => :logger, :tracer => :string}
    # @ah2 = Tracing::ActionHandler.new(:filters => @filters = [Module_filter_A, Method_filter_A], :appenders => appender_options)    

    @ah3 = Tracing::ActionHandler.new(:filters => @filters = [Module_filter_A, Method_filter_A], :appenders => :logger)        
  end

  def teardown
    ## Nothing really
  end
    
  def test_filter
    puts "ActionHandler:" + @ah3.inspect
  end
  
  
end


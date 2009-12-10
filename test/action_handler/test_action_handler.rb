require 'include'
 
class TestFilter < Test::Unit::TestCase

  def setup
    # tla1 = Tracing::TemplateLogAppender.new(:options => {:overwrite => false, :time_limit => 2.minutes}, :tracer => :string)      
    # action handler is configured with a set of filters and a set of appenders
    # the appenders are called in turn if log statement passes all filters!
    appender_options = {:options => {:overwrite => false, :time_limit => 2.minutes}, :type => :logger, :tracer => :string}
    @ah2 = {:filters => [Module_filter_A, Method_filter_A], :appenders => appender_options}.action_handler

    @ah3 = {:filters => [Module_filter_A, Method_filter_A], :appenders => :logger}.action_handler        
  end

  def test_filter
    puts "ActionHandler:" + @ah3.inspect
  end
  
  
end


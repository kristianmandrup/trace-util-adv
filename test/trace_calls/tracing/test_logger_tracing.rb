require "trace_util_adv"
require "samples/include"
  
class TestLoggerTracing < Test::Unit::TestCase
            
  def test_logger_tracing    
    classes_to_trace = [ 'My']            
    Tracing::LoggerAppender.default_path = 'log_files'        
    Tracing::TraceCalls.configure(:type => :log, :filters => Method_filter_hello)                
    my = Me::My.new
    my.hello
    my.hi_there
    my.blip
    my.blap
  end
  
end


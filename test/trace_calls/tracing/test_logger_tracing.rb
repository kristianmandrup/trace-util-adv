require "../include"
  
class TestLoggerTracing < Test::Unit::TestCase
            
  def test_logger_tracing    
    classes_to_trace = [ 'My']            
    # Should be for LogFileAppender
    # Tracing::LoggerAppender.default_path = 'log_files'        

    Tracing::TraceExt.configure(:type => :log, :filters => Method_filter_hello)                
    my = Me::My.new
    my.hello
    my.hi_there
    my.blip
    my.blap
  end
  
end


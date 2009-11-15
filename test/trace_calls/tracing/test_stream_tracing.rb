require "trace_util_adv"
require "samples/include"
  
class TestStreamTracing < Test::Unit::TestCase
            
  def test_stream_tracing    
    classes_to_trace = [ 'My']            
    Tracing::TraceCalls.configure(:type => :stream, :filters => Method_filter_hello)                
    my = Me::My.new
    my.hello
    my.hi_there
    my.blip
    my.blap
  end
  
end


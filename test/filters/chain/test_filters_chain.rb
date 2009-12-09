require "../include"

class TestFilter < Test::Unit::TestCase

  attr_reader :ah1, :filters

  def setup
  end

  def teardown
    ## Nothing really
  end
            
  def test_filter
    # Tracing::TraceExt.configure(:appenders => :logger, :filters => [Method_filter_A, Method_filter_B])            
    Me::My.class_eval { include Tracing::TraceCalls }
        
    Tracing::HtmlAppender.default_path = 'log_files/html'

    names_A = %w{blip blop}
    names_B = "blip blop"
    names_C = "blip, blop"
    bfil = {:xmethod_filter => names_B}

    my_method_filter = {:xmethod_filter => "method_a, method b"}

    # method_filter_A = Tracing::Filter.create_filter({:imethod_filter =>  names_A})        
    method_filter_B = Tracing::Filter.create_filter(bfil)        
    # method_filter_C = Tracing::Filter.create_filter({:imethod_filter =>  names_C})        
        
    # Tracing::TraceExt.configure(:appenders => {:type => :html, :to_file => 'log_files/html/traced.html'})    
    meth_filter_A = {:imethod_filter =>  names_A}
        
    puts "mf B: " + method_filter_B.inspect    
        
    Tracing::TraceExt.configure(:appenders => {:type => :html, :to_file => 'traced4.html'}, :filters => [meth_filter_A], :final_yield => :exclude)        
    
    # puts "Handlers configured:" + Tracing::TraceExt.action_handlers.inspect    
            
    # 
    my = Me::My.new
    my.hello
    my.hi_there
    my.blip
    my.blap
    
  end
  
  
end


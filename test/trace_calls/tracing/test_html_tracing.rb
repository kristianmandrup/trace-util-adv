require "../include"

class TestHtmlTracing < Test::Unit::TestCase
            
  def test_html_tracing    
    classes_to_trace = [ 'My']            
    Tracing::HtmlAppender.default_path = 'log_files/html'        
    Tracing::TraceExt.configure(:type => :html, :to_file => 'traced_dryml.html', :filters => Method_filter_hello)                
    my = Me::My.new
    my.hello
    my.hi_there
    my.blip
    my.blap

  end
  
  
end


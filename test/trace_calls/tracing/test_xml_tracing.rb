require "../include"
  
class TestXmlTracing < Test::Unit::TestCase
            
  def test_xml_tracing    
    classes_to_trace = [ 'My']            
    Tracing::XmlAppender.default_path = 'log_files/xml'        
    Tracing::TraceExt.configure(:type => :xml, :to_file => 'traced_dryml.html', :filters => Method_filter_hello)                
    my = Me::My.new
    my.hello
    my.hi_there
    my.blip
    my.blap
  end
  
end


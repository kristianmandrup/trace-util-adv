require "../include"
  
class TestDrymlTemplateLogTracing < Test::Unit::TestCase
            
  def test_dryml_template_tracing    
    classes_to_trace = [ 'My']            
    Tracing::TemplateLogAppender.default_path = 'log_files/templates'        
    Tracing::TraceExt.configure(:type => :template_log, :filters => Method_filter_dryml)                
    my = Me::My.new
    my.hello
    my.hi_there
    my.blip
    my.blap
  end
  
end


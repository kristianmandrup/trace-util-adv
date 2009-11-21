require 'include'
 
class TestCreateActionHandler < Test::Unit::TestCase

  def test_action_handlers
    config = {:action_handlers => []}
    result = config.action_handlers
    assert_equal result.blank?, true, "Should result in empty action_handler list"    

    config = {:action_handlers => {:appenders => :html}}
    result = config.action_handlers
    assert_equal Tracing::HtmlAppender, result.appenders[0].class, "Should result in action handler with HtmlAppender registered"    
  end
  
  def test_ah
    config = {:action_handlers => {:filters => {:i_method_filter => "a,b"}}}
    result = config.action_handlers
    assert_equal Tracing::MethodFilter, result.filters[0].class, "Should result in action handler with MethodFilter registered"    
    
    ah1 = {:filters => {:i_method_filter => "a,b"}, :appenders => :html}
    ah2 = {:filters => {:x_method_filter => "c,d"}, :appenders => :xml}
      
    config = {:action_handlers => [ah1, ah2]}
    result = config.action_handlers
    assert_equal Tracing::MethodFilter, result[0].filters[0].class, "Should result in action handler with MethodFilter registered"    
    assert_equal Tracing::MethodFilter, result[1].filters[0].class, "Should result in action handler with MethodFilter registered"    
  end
end
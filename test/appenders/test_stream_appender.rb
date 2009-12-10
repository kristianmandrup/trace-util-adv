require "include"
require 'appender_test_case'
 
class TestStreamAppender < Test::Unit::TestCase

  def setup
    @appender = {:appender => :stream, :stream => :out}.appender      
    @ctx = Context.ctx1
  end
        
  def test_filter
    p @ctx
    
    res = @ah1.allow_append("BEGIN #{name}", @ctx)    
    name = "my_other_method"

    @ctx[:method_name] = name
    @ctx.context

    res = @ah1.allow_append("BEGIN #{name}", @ctx)        
    # puts res
    
    @ctx[:result] = "32"
    res = @ah1.allow_append("END #{name}", @ctx)    

    assert res, "Should work"

    name = "my_method"
    @ctx[:method_name] = name
    @ctx.context    
    
    @ctx[:result] = "27"
    res = @ah1.allow_append("END #{name}", @ctx)    
    
    assert res, "Should work"
  end
  
  
end


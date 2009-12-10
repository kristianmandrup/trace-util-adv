module AppenderTestCase

  def test_allow_append    
    res = @appender.allow_append("BEGIN #{name}", @ctx)    
    name = "my_other_method"

    @ctx[:method_name] = name
    @ctx.context

    res = @appender.allow_append("BEGIN #{name}", @ctx)        
    # puts res
  
    @ctx[:result] = "32"
    res = @appender.allow_append("END #{name}", @ctx)    

    assert res, "Should work"

    name = "my_method"
    @ctx[:method_name] = name
    @ctx.context    
  
    @ctx[:result] = "27"
    res = @appender.allow_append("END #{name}", @ctx)    
  
    assert res, "Should work"
  end

end
require "../include"


class TestBaseFilter < Test::Unit::TestCase

  def setup
  end

  def teardown
    ## Nothing really
  end
            
  def test_default_name
    bf = Tracing::BaseFilter.new({})
    assert_equal "Unknown filter", bf.name, "Should result name:'Unknown filter'"
  end
  
  def test_create_w_name
    bf = Tracing::BaseFilter.new({:name => 'base'})
    assert_equal "base", bf.name, "Should result in name:'base'"
  end

  def test_create_w_name
    bf = Tracing::BaseFilter.new({:name => 'base'})
    assert_equal "base", bf.name, "Should result in name:'base'"
  end
    
  def test_register_filters          
    Tracing::BaseFilter.new({:name => 'base'})
    bF = Tracing::BaseFilter
    
    f1 = {:x => :y}
    bF.register_filters(f1)
    expect = {:x => :y}    
    assert_equal expect, bF.filters, "Should result in x=>y filter"

    f2 = {:z => :a}
    bF.register_filters(f2)
    expect = {:z=>:a, :x=>:y}
    assert_equal expect, bF.filters, "Should result in x=>y and z=>a filter"        
  end
  
  def test_unregister_filters    
    bf = Tracing::BaseFilter.new({:name => 'base'})
    bF = Tracing::BaseFilter
    # clear old filters
    bF.filters = {}
    f1 = {:x => :y}
    bF.unregister_filters(f1)
    assert_equal({}, bF.filters, "Should result in empty filter")
    f2 = {:z => :a, :x => :y}
    bF.register_filters(f2)
    bF.unregister_filters(f1)
    expect = {:z=>:a}
    assert_equal expect, bF.filters, "Should result in z=>a filter"        
  end
  
end

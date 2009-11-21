require "../include"

class TestFilterExec < Test::Unit::TestCase

  def setup
    @context = {:class_name => "Alpha::Beta::Gamma", :method_name => "meth_a", :vars => {:template_path => 'rapid'}, :args => {:a => 7} }.context
  end

  def teardown
    ## Nothing really
  end

  # include method
  def test_single_filter_allow
    im_filter = {:i_method_filter => "meth_b, meth_a"} 
    options = {:filters => im_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', @context)
    assert_equal true, result, "Filter should allow passage"    
  end
  

  # exclude method
  def test_single_filter_not_allow
    xm_filter = {:x_method_filter => "meth_b, meth_a"} 
    options = {:filters => xm_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', @context)
    assert_equal false, result, "Filter should not allow passage"    
  end

  # yield include
  def test_single_filter_yield_include
    xm_filter = {:x_method_filter => "meth_b, meth_c"} 
    options = {:filters => xm_filter, :final_yield_action => :include}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', @context)
    assert_equal true, result, "Filter should not allow passage"    
  end

  def test_single_filter_yield_exclude
    xm_filter = {:x_method_filter => "meth_b, meth_c"} 
    options = {:filters => xm_filter, :final_yield_action => :exclude}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', @context)
    assert_equal false, result, "Filter should not allow passage"    
  end

  def test_single_filter_yield_exclude_default
    xm_filter = {:x_method_filter => "a,b"} 
    # :final_yield_action => :exclude by default
    options = {:filters => xm_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', @context)
    assert_equal false, result, "Filter should not allow passage"    
  end

  def test_two_filters
    im_filter = {:i_method_filter => "meth_b, meth_a"} 
    xm_filter = {:x_method_filter => "a,b"} 
    options = {:filters => [im_filter, xm_filter] }    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', @context)
    assert_equal true, result, "Should allow passage"
  end
  
  def test_two_yield_filters
    iy_filter = {:iy_method_filter => "meth_b, meth_a"} 
    xy_filter = {:xy_method_filter => "meth_b, meth_c"} 
    options = {:filters => [iy_filter, xy_filter]}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', @context)
    assert_equal true, result, "Should allow passage"
  end

  
end


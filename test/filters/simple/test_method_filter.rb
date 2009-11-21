require "../include"

Method_filter = {
  :name => 'my methods',  
  :method_rules => [{
    # id of method rule set
    :name => 'my_methods',
    :include => [/by.*/, 'build_a', 'do_it'],
    :exclude => ['add.*'],
    :exclude_and_yield => ['blip'],
    :default => :exclude
  }]
}


class TestMethodFilter < Test::Unit::TestCase

  def test_method_filter_hash_to_class
    composite_filter = Method_filter
    result = composite_filter.filter_class
    assert_equal Tracing::MethodFilter, result, "Should result in method filter"    
  end

  def test_method_filter_hash_to_class
    composite_filter = Method_filter
    result = composite_filter.create_filter
    assert_equal Tracing::MethodFilter, result.class, "Should result in method filter"    
  end
  
  
  def test_method_filter_from_hash
    composite_filter = Method_filter
    config = {:filters => composite_filter}    
    result = config.filters
    assert_equal Tracing::MethodFilter, result.class, "Should result in method filter"    
  end

  # see allow_action in MethodFilter, refactor :yield, :include .. as return values!?
  def test_method_filter__class_and_method_match
    composite_filter = Method_filter
  
    context = { :class_name => "Hobo::Dryml", :method_name => "build_a"}.context
  
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal true, result, "Filter should allow passage"    
  end

  def test_method_filter__method_not_match
    composite_filter = Method_filter
  
    context = { :class_name => 'Blip::Blap', :method_name => "blop"}.context
    
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end

  def test_method_filter__method_excluded
    composite_filter = Method_filter
  
    context = { :class_name => "Hobo::Dryml", :method_name => "add_it"}.context
    
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end
              
end
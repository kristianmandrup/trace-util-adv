require "../include"

Class_composite_filter_A = {
  # id of composite rule set  
  :name => 'Template stuff',
  :default => :exclude,
  :classes => [{
    :names => [/Dryml/],
    :method_rules => {
      :include => [/build.*/, 'exec'],
      :exclude => ['add'],
      :default => :exclude
    }
  }]
}

class TestCompositeFilter < Test::Unit::TestCase

  def test_composite_class_filter_hash_to_class
    composite_filter = Class_composite_filter_A
    result = composite_filter.filter_class
    assert_equal Tracing::CompositeClassFilter, result, "Should result in composite class filter"    
  end

  def test_composite_class_filter_hash_to_class
    composite_filter = Class_composite_filter_A
    result = composite_filter.create_filter
    assert_equal Tracing::CompositeClassFilter, result.class, "Should result in composite class filter"    
  end
  
  
  def test_composite_class_filter_from_hash
    composite_filter = Class_composite_filter_A
    config = {:filters => composite_filter}    
    result = config.filters
    assert_equal Tracing::CompositeClassFilter, result.class, "Should result in method filter"    
  end

  # see allow_action in CompositeClassFilter, refactor :yield, :include .. as return values!?
  def test_composite_class_filter__class_and_method_match
    composite_filter = Class_composite_filter_A
  
    context = {:class_name => "Hobo::Dryml", :method_name => "build_a"}.context
  
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal true, result, "Filter should allow passage"    
  end

  def test_composite_class_filter__class_not_match
    composite_filter = Class_composite_filter_A
  
    context = {}    
    context.set_context :class_name => 'Blip::Blap'
    
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end

  def test_composite_class_filter__method_excluded
    composite_filter = Class_composite_filter_A
  
    context = {}    
    context.set_context :class_name => "Hobo::Dryml", :method_name => "add_it"
    
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end
              
end
require "../include"

Class_filter = {
  :name => 'my classes',  
  :class_rules => [{
    # id of class rule set
    :name => 'my_classes',
    :include => [/Dryml/],
    :exclude => [/NotMy/],
    :default => :yield
  }]
}

class TestFilter < Test::Unit::TestCase

  def test_class_filter_hash_to_class
    class_filter = Class_filter
    result = class_filter.filter_class
    assert_equal Tracing::ClassFilter, result, "Should result in  class filter"    
  end
  
  def test_class_filter_hash_to_class
    class_filter = Class_filter
    result = class_filter.create_filter
    assert_equal Tracing::ClassFilter, result.class, "Should result in  class filter"    
  end
  
  
  def test_class_filter_from_hash
    class_filter = Class_filter
    config = {:filters => class_filter}    
    result = config.filters
    assert_equal Tracing::ClassFilter, result.class, "Should result in method filter"    
  end

  # see allow_action in ClassFilter, refactor :yield, :include .. as return values!?
  def test_class_filter__class_and_method_match
    class_filter = Class_filter
  
    context = {:class_name => "Dryml", :method_name => "build_a"}.context
  
    options = {:filters => class_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal true, result, "Filter should allow passage"    
  end

  def test_class_filter__class_not_match
    class_filter = Class_filter
  
    context = {:class_name => 'Blip::Blap'}.context    
    
    options = {:filters => class_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end
  
  def test_class_filter__method_excluded
    class_filter = Class_filter
  
    context = {:class_name => "Hobo::Blip"}.context
    
    options = {:filters => class_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end
              
end
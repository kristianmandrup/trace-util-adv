require "../include"

Module_composite_filter_A = {
  # id of composite rule set    
  :name => 'dryml_filter',
  :modules => [{
    :names => ['Hobo::Dryml', /Dryml/],
    :class_rules => {
      :include => [/Template.*/, 'DRYMLBuilder'],
      :exclude => ['Taglib'],
      :default => :include
    },
    :method_rules => {
      :include => [/blip.*/, 'blap'],
      :exclude => ['add_it'],
      :default => :include
    }
  }]
}


class TestCompositeModuleFilter < Test::Unit::TestCase

  def test_composite_module_filter_hash_to_module
    composite_filter = Module_composite_filter_A
    result = composite_filter.filter_module
    assert_equal Tracing::CompositeModuleFilter, result, "Should result in composite module filter"    
  end

  def test_composite_module_filter_hash_to_module
    composite_filter = Module_composite_filter_A
    result = composite_filter.create_filter
    assert_equal Tracing::CompositeModuleFilter, result.class, "Should result in composite module filter"    
  end

  def test_composite_module_filter_from_hash
    composite_filter = Module_composite_filter_A
    config = {:filters => composite_filter}    
    result = config.filters
    assert_equal Tracing::CompositeModuleFilter, result.class, "Should result in composite module filter"    
  end

  # see allow_action in CompositeModuleFilter, refactor :yield, :include .. as return values!?
  def test_composite_module_filter__module_and_method_match
    composite_filter = Module_composite_filter_A
  
    context = {}
    context.set_context :modules => ["Hobo", "Dryml"], :method_name => "build_a" #, :class_name => "Dryml" 
  
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal true, result, "Filter should allow passage"    
  end
      
      
  def test_composite_module_filter__module_not_match
    composite_filter = Module_composite_filter_A
  
    context = {}    
    context.set_context :modules => ['Blip', 'Blap']
    
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end
  
  def test_composite_module_filter__method_excluded
    composite_filter = Module_composite_filter_A
  
    context = {}    
    context.set_context :modules => ["Hobo", "Dryml"], :method_name => "add_it"
    
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end              
end
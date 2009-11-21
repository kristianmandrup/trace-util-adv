require "../include"

Module_filter = {
  :name => 'my modules',
  :default => :exclude,
  :module_rules => [{
    # id of modules rule set
    :name => ['my_modules'],
    :include => [/Hobo/],
    :exclude => [/Dryml/],
    :default => :exclude
  }]
}

class TestModuleFilter < Test::Unit::TestCase

  def test_module_filter_hash_to_module
    _filter = Module_filter
    result = _filter.filter_module
    assert_equal Tracing::ModuleFilter, result, "Should result in  module filter"    
  end

  def test_module_filter_hash_to_module
    _filter = Module_filter
    result = _filter.create_filter
    assert_equal Tracing::ModuleFilter, result.class, "Should result in  module filter"    
  end

  def test_module_filter_from_hash
    _filter = Module_filter
    config = {:filters => _filter}    
    result = config.filters
    puts result.inspect
    assert_equal Tracing::ModuleFilter, result.class, "Should result in  module filter"    
  end

  # see allow_action in ModuleFilter, refactor :yield, :include .. as return values!?
  def test_module_filter__module_and_method_match
    _filter = Module_filter
  
    context = { :modules => ["Hobo"], :method_name => "build_a", :class_name => "Dryml" }.context
  
    options = {:filters => _filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal true, result, "Filter should allow passage"    
  end
      
  # TODO: Doesn't Work :(
  def test_module_filter__module_not_match
    _filter = Module_filter
  
    context = {:modules => ["Blip", "Blop"], :method_name => "build_a", :class_name => "Dryml"}.context
    
    puts context.inspect
    
    options = {:filters => _filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
  
    puts "Result:" + result.inspect  
  
    assert_equal false, result, "Filter should NOT allow passage"    
  end
  
end
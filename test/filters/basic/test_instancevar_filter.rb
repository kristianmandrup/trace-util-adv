require 'filters/filter_exec'
require 'extensions/core_extensions'
require "test/unit"

InstanceVar_filter = {
  :name => 'check template path',
  :var_name => 'template_path',
  :var_rules => {
    :include => [/.*\/taglib\/.*/], 
    :exclude => [/.*\/rapid_.*/],
    :default => :exclude         
  }
}

class Obj
  attr_accessor :template_path
  
  def initialize(value = nil)
    @template_path = value  
  end
end

class TestInstanceVarFilter < Test::Unit::TestCase

  def test_varfilter_hash_to_class
    var_filter = InstanceVar_filter
    result = var_filter.filter_class
    assert_equal Tracing::InstanceVarFilter, result, "Should result in var filter"    
  end

  def test_varfilter_hash_to_class
    var_filter = InstanceVar_filter
    result = var_filter.create_filter
    assert_equal Tracing::InstanceVarFilter, result.class, "Should result in var filter"    
  end
  
  
  def test_varfilter_from_hash
    var_filter = InstanceVar_filter
    config = {:filters => var_filter}    
    result = config.filters
    assert_equal Tracing::InstanceVarFilter, result.class, "Should result in var filter"    
  end

  # see allow_action in InstanceVarFilter, refactor :yield, :include .. as return values!?
  def test_varfilter__class_and_varmatch
    var_filter = InstanceVar_filter
  
    context = {}
    context.set_context :class_name => "Hobo::Dryml", :vars => {"template_path" => "a/taglib/x"}
  
    options = {:filters => var_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal true, result, "Filter should allow passage"    
  end

  def test_varfilter__varnot_match
    var_filter = InstanceVar_filter
  
    context = {}    
    context.set_context :class_name => 'Blip::Blap', :vars => ["template_path"]
    
    context[:self] = Obj.new "blop"
    
    puts "Context:" + context.inspect
    
    options = {:filters => var_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end
  
  def test_varfilter__varexcluded
    var_filter = InstanceVar_filter
  
    context = {}    
    context.set_context :class_name => 'Blip::Blap', :vars => ["template_path"]
    
    context[:self] = Obj.new "a/rapid_x"

    
    options = {:filters => var_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end
              
end
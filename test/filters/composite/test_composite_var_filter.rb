require "../include"

# for specific instance_vars, match on values (after .to_s on var)  

# include if @template_path MATCHES 'taglib'
# exclude if @template_path MATCHES 'rapid_'
# exclude if @builder MATCHES 'bad_'
Var_composite_filter = {
  :name => 'template_path',
  :default => :exclude,  
  :vars => [
  # include if @template_path MATCHES 'taglib'
  # exclude if @template_path MATCHES 'rapid_'    
  {
    :name => 'template_path',
    :var_rules => {
      :include => [/.*\/taglib\/.*/], 
      :exclude => [/.*\/rapid_.*/],       
      :default => :exclude_and_yield
    } 
  },
  # exclude if @builder MATCHES 'bad_'  
  {
  :name => 'builder', 
    :var_rules => {
      :exclude => [/.*\/bad.*/],         
      :default => :include
    } 
  }]
}

class Obj
  attr_accessor :template_path
  
  def initialize(value = nil)
    @template_path = value  
  end
end

class TestCompositeInstanceVarFilter < Test::Unit::TestCase

  def test_composite_var_filter_hash_to_var
    composite_filter = Var_composite_filter
    result = composite_filter.filter_class
    assert_equal Tracing::ListInstanceVarFilter, result, "Should result in composite var filter"    
  end

  def test_composite_var_filter_hash_to_var
    composite_filter = Var_composite_filter
    result = composite_filter.create_filter
    assert_equal Tracing::ListInstanceVarFilter, result.class, "Should result in composite var filter"    
  end  
  
  def test_composite_var_filter_from_hash
    composite_filter = Var_composite_filter
    config = {:filters => composite_filter}    
    result = config.filters
    assert_equal Tracing::ListInstanceVarFilter, result.class, "Should result in composite var filter"    
  end

  # see allow_action in CompositeInstanceVarFilter, refactor :yield, :include .. as return values!?
  
  def test_composite_var_filter__var_and_method_match
    composite_filter = Var_composite_filter
  
    context = {:vars => ["template_path" => 'b/taglib/b'], :self => Obj.new('b/taglib/b')}.context
  
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal true, result, "Filter should allow passage"    
  end

  def test_composite_var_filter__var_not_match
    composite_filter = Var_composite_filter
  
    context = {:class_name => 'Blip::Blap', :vars => ["template_path" => 'rapid']}    
    context[:self] = Obj.new "blop"
    
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end
  
  def test_composite_var_filter__method_excluded
    composite_filter = Var_composite_filter
  
    context = {}    
    context.set_context :class_name => 'Blip::Blap', :vars => ["template_path" => 'blip']    
    context[:self] = Obj.new "a/rapid_x"
    
    options = {:filters => composite_filter}    
    exec = Tracing::Filter::Executor.new(options)       
    result = exec.filters_allow?('msg', context)
    assert_equal false, result, "Filter should NOT allow passage"    
  end

          
end
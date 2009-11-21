require '../include'

class CustomNameFilter < Tracing::NameFilter 
  
  def initialize(options)
      super(options)
  end
  
  def allow?(name)
    name == options[:name]
  end    
end


class TestSymbolExtensions < Test::Unit::TestCase

  def setup
    # Procs of this form can be used as filters inside include/exclude lists
    abc_filter = Proc.new {|name| name == 'abc' }
    name_filter = CustomNameFilter.new({:name => 'rapid'})   
    @meth_filter_abc = {:i_method_filter => [abc_filter], :default => :exclude}.filters
    @meth_filter_name = {:i_method_filter => [name_filter], :default => :exclude}.filters
    @meth_filter_comb = {:i_method_filter => [abc_filter, name_filter], :default => :exclude}.filters
    
    @context_abc = {:modules => ["Hobo"], :class_name => "Dryml", :method_name => "abc"}.context
    @context_rapid = {:modules => ["Hobo"], :class_name => "Dryml", :method_name => "rapid"}.context    
  end

  def teardown
    ## Nothing really
  end
            
  def test_custom_name_filter
    res = @meth_filter_name.allow_action("hello", @context_abc)
    assert_equal :yield, res, "Should allow since matching method name 'abc'"
  end

  def test_custom_proc_filter
    res = @meth_filter_abc.allow_action("hello", @context_rapid)
    assert_equal :yield, res, "Should allow since matching method name 'rapid'"    
  end

  def test_custom_filters
    res = @meth_filter_comb.allow_action("hello", @context_abc)
    assert_equal :include, res, "Should allow since matching method name 'abc'"    
  end
    
end




 
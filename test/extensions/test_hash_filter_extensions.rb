require "include"


class TestHashFilterFilter < Test::Unit::TestCase

  def setup
  end

  def teardown
    ## Nothing really
  end
            
  def test_try_create_method_include_filter
    hash = {:i_method_filter => 'a,b'}
    mfilter = hash.create_filter
    expected = Tracing::MethodFilter
    assert_equal expected, mfilter.class, "Should create method include filter"
    exp = {:include => "a,b"}
    assert_equal exp, mfilter.rules, "Expected include rules"
  end
  
  def test_try_create_method_exclude_filter
    hash = {:x_method_filter => 'a,b'}
    mfilter = hash.create_filter
    expected = Tracing::MethodFilter
    assert_equal expected, mfilter.class, "Should create method exclude filter"
    exp = {:exclude =>"a,b"}
    assert_equal exp, mfilter.rules, "Expected exclude rules"
  end
  
  def test_try_create_method_include_and_yield_filter
    hash = {:iy_method_filter => 'a,b'}
    mfilter = hash.create_filter
    expected = Tracing::MethodFilter
    assert_equal expected, mfilter.class, "Should create method include filter"
    exp = {:include_and_yield => "a,b"}
    assert_equal exp, mfilter.rules, "Expected include and yield rules"
  end
  
  def test_create_method_exclude_and_yield_filter
    hash = {:xy_method_filter => 'a,b'}
    mfilter = hash.create_filter
    expected = Tracing::MethodFilter
    puts "FILTER: #{mfilter.inspect}"        
    assert_equal expected, mfilter.class, "Should create method exclude filter"
    exp = {:exclude_and_yield => "a,b"}
    assert_equal exp, mfilter.rules, "Expected exclude and yield rules"
  end
  
  def test_try_create_class_exclude_and_yield_filter
    hash = {:xy_class_filter => 'a,b'}
    mfilter = hash.create_filter
    expected = Tracing::ClassFilter
    assert_equal expected, mfilter.class, "Should create class exclude filter"
    exp = {:exclude_and_yield => "a,b"}
    puts mfilter.inspect
    assert_equal exp, mfilter.rules, "Expected exclude and yield rules"
  end
  
  def test_try_create_module_exclude_and_yield_filter
    hash = {:xy_module_filter => 'a,b'}
    mfilter = hash.create_filter
    expected = Tracing::ModuleFilter
    assert_equal expected, mfilter.class, "Should create module exclude filter"
    exp = {:exclude_and_yield => "a,b"}
    puts mfilter.inspect
    assert_equal exp, mfilter.rules, "Expected exclude and yield rules"
  end
  
  def test_try_create_vars_exclude_and_yield_filter
    hash = {:xy_vars_filter => 'a,b'}
    mfilter = hash.create_filter
    expected = Tracing::InstanceVarFilter
    assert_equal expected, mfilter.class, "Should create vars exclude filter"
    exp = {:exclude_and_yield => "a,b"}
    puts mfilter.inspect
    assert_equal exp, mfilter.rules, "Expected exclude and yield rules"
  end
  
  
end


require 'core_extensions'
require "test/unit"


class TestFilter < Test::Unit::TestCase

  def setup
  end

  def teardown
    ## Nothing really
  end
            
  def test_try_create_method_include_filter
    hash = {:imethod_filter => 'a,b'}
    filter_hash = hash.try_create_filter(:method_filter)
    # puts filter_hash.inspect
    assert_equal filter_hash, {:method_filter => {:include => "a,b"}}, "Should create method include filter"
  end
  
  def test_try_create_method_exclude_filter
    hash = {:xmethod_filter => 'a,b'}
    filter_hash = hash.try_create_filter(:method_filter)
    # puts filter_hash.inspect
    assert_equal filter_hash, {:method_filter => {:exclude => "a,b"}}, "Should create method exclude filter"
  end

  def test_try_create_method_include_and_yield_filter
    hash = {:iymethod_filter => 'a,b'}
    filter_hash = hash.try_create_filter(:method_filter)
    # puts filter_hash.inspect
    assert_equal filter_hash, {:method_filter => {:include_and_yield => "a,b"}}, "Should create method include_an_yield filter"
  end

  def test_try_create_method_exclude_and_yield_filter
    hash = {:xymethod_filter => 'a,b'}
    filter_hash = hash.try_create_filter(:method_filter)
    # puts filter_hash.inspect
    assert_equal filter_hash, {:method_filter => {:exclude_and_yield => "a,b"}}, "Should create method exclude_and_yield filter"
  end

  def test_try_create_class_exclude_and_yield_filter
    hash = {:xyclass_filter => 'a,b'}
    filter_hash = hash.try_create_filter(:class_filter)
    # puts filter_hash.inspect
    assert_equal filter_hash, {:class_filter => {:exclude_and_yield => "a,b"}}, "Should create class exclude_and_yield filter"
  end

  def test_try_create_module_exclude_and_yield_filter
    hash = {:xymodule_filter => 'a,b'}
    filter_hash = hash.try_create_filter(:module_filter)
    # puts filter_hash.inspect
    assert_equal filter_hash, {:module_filter => {:exclude_and_yield => "a,b"}}, "Should create module exclude_and_yield filter"
  end

  def test_try_create_vars_exclude_and_yield_filter
    hash = {:xyvars_filter => 'a,b'}
    filter_hash = hash.try_create_filter(:vars_filter)
    # puts filter_hash.inspect
    assert_equal filter_hash, {:vars_filter => {:exclude_and_yield => "a,b"}}, "Should create vars exclude_and_yield filter"
  end

  
end


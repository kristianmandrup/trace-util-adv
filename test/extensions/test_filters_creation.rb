require 'extensions/core_extensions'
require 'filters/base_filters'
require 'rules/hash_rule_extensions'
require "test/unit"


class TestFiltersCreation < Test::Unit::TestCase

  def test_try_create_method_include_filter
    hash = {:i_method_filter => 'a,b'}
    filter_hash = hash.create_filter
    expected = {:method_filter => {:include => "a,b"}}
    puts filter_hash.inspect
    assert_equal expected, filter_hash, "Should create method include filter"
  end

  def test_filters_creation
    # config = {:filters => []}
    # result = config.filters
    # assert_equal result.blank?, true, "Should result in empty filters list"    

    im_filter = {:i_method_filter => "a,b"}
    config = {:filters => im_filter}
    
    res = im_filter.filters
    puts "res: #{res.inspect}"
    
    result = config.filters
    puts "result: #{result.inspect}"
    # assert_equal Tracing::MethodFilter, result.class, "Should result in method filter"    
  
    # puts "rules: #{result.rules.inspect}"
    # expected = {:method_filter => {:include => "a, b"} }
    # assert_equal expected, result.rules, "Should result in method rules"    
  end
end
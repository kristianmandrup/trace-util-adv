require "include"

class TestFilter < Test::Unit::TestCase
            
  def test_split_names
    names = nil
    result = names.split_names
    expected = ["alpha", "beta"]
    assert_equal nil, result, "No names should result in nil"

    names = "alpha, beta"
    result = names.split_names
    expected = ["alpha", "beta"]
    assert_equal expected, result, "Should be split into list of names"

    names = "alpha   beta"
    result = names.split_names
    expected = ["alpha", "beta"]
    assert_equal expected, result, "Should be split into list of names"

    names = "alpha  ,   beta"
    result = names.split_names
    expected = ["alpha", "beta"]
    assert_equal expected, result, "Should be split into list of names"
  end
  
  def test_modules
    name = "Alpha::Beta::Gamma"
    result = name.modules
    expected = ["Alpha","Beta"]
    assert_equal expected, result, "Should be split into list of module names"    
  end

  def test_class_name
    name = "Alpha::Beta"    
    result = name.class_name
    expected = "Beta"
    assert_equal expected, result, "Should be last part of module name"
  end
  
  def test_in_module?(module_name)
    name = "Alpha::Beta"    
    result = name.in_module?("Alpha")
    expected = true
    assert_equal expected, result, "Should be in module"

    result = name.in_module?("Gamma")
    expected = true
    assert_equal expected, result, "Should NOT be in module"
  end  
  
end


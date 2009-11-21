require "include"

class TestFiltersCreation < Test::Unit::TestCase

  def test_try_create_method_include_filter
    hash = {:i_method_filter => 'a,b'}
    imethod_filter = hash.create_filter
    expected = Tracing::MethodFilter
    assert_equal expected, imethod_filter.class, "Should create method include filter"
  end

end
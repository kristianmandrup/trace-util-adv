require "include"

class TestHashExtensions < Test::Unit::TestCase

  def setup
  end

  def teardown
    ## Nothing really
  end

  def test_map
    mapper = {:x => 1, :y => 2, :default => 3}
    result = mapper.map(:x)
    assert_equal result, 1, ":x Should result in 1"
    result = mapper.map(:w)
    assert_equal result, 3, ":w Should result in default 3"
  end
  
  def test_method_full_name
    my_instance_variables = {:template_path => 'taglibs/rapid_core.dryml'}    
    context = {:class_name => "Alpha::Beta::Gamma", :method_name => "meth_a", :vars => [my_instance_variables], :args => {:a => 7} }.context
    puts context
    result = context.full_method_name
    assert_equal result, 'Alpha::Beta::Gamma.meth_a', "Should result in 'Alpha::Beta::Gamma.meth_a'"
  end
  
  def test_rules_allow_action_include
    rule = {:include => ['a']}
    result = rule.rules_allow_action('a')
    assert_equal result, :include, "Should include a"
  end
  
  def test_rules_allow_action_yield
    rule = {:include => ['a']}
    result = rule.rules_allow_action('b')
    assert_equal result, :yield, "Should yield a"
  end
  
  def test_rules_allow_action_exclude
    rule = {:exclude => ['a']}
    result = rule.rules_allow_action('a')
    assert_equal result, :exclude, "Should exclude a"
  end
  
  def test_rules_allow_action_exclude_and_yield
    rule = {:exclude_and_yield => ['a']}
    result = rule.rules_allow_action('a')
    assert_equal result, :exclude_and_yield, "Should exclude_an_yield a"
  end
  
  # TODO
  # rule_allow_action(name) NEEDS MAJOR CLEANUP AND REFACTOR!!!
  def test_rules_allow_action_include_and_yield
    rule = {:include_and_yield => ['a']}
    result = rule.rules_allow_action('a')
    assert_equal result, :include_and_yield, "Should include_an_yield a"
  end
  
  def test_rule_list
    rules = ['a']
    result = rules.rule_list
    assert_equal result, rules, "Should not change rule"
  
    rules = ['a', 'b']
    result = rules.rule_list
    assert_equal result, rules, "Should not change rules"
  
    rules = "a b"
    result = rules.rule_list
    assert_equal result, ['a', 'b'], "Should split rules"
  end
  
  # return a symbol, either - :include, :exclude or :yield (let next filter decide)
  def test_rule_allow_action
    rule = {:include => ['a']}
    result = rule.rule_allow_action('a')
    assert_equal result, :include, "Should :include"
  
    rule = {:exclude => ['a']}
    result = rule.rule_allow_action('a')
    assert_equal result, :exclude, "Should :exclude"
  
    rule = {:include_and_yield => ['a']}
    result = rule.rule_allow_action('a')
    assert_equal result, :include_and_yield, "Should :include_and_yield"
  
    rule = {:exclude_and_yield => ['a']}
    result = rule.rule_allow_action('a')
    assert_equal result, :exclude_and_yield, "Should :exclude_and_yield"
  
    rule = {:yield => ['a']}
    result = rule.rule_allow_action('a')
    assert_equal result, :yield, "Should :yield"
  
    rule = {:include => ['a']}
    result = rule.rule_allow_action('a')
    assert_equal result, :include, "Should :include"
  
    rule = {:include => ['b'], :exclude => "a"}
    result = rule.rule_allow_action('a')
    assert_equal result, :exclude, "Should :exclude"
  
    rule = {:include => ['a'], :exclude => "a"}
    result = rule.rule_allow_action('a')
    assert_equal result, :include, "Should :include"
  
  end
  
  def test_create_template
    rule = {:template => :html}
    result = rule.template
    assert_equal result.class, Tracing::HtmlTemplate, "Should result in HtmlTrace"    
  
    rule = {:template => :xml}
    result = rule.template
    assert_equal result.class, Tracing::XmlTemplate, "Should result in XmlTrace"    
  
    rule = {:template => :string}
    result = rule.template
    assert_equal result.class, Tracing::StringTemplate, "Should result in StringTrace"    
  end
  
  
  def test_action_handlers
    config = {:action_handlers => []}
    result = config.action_handlers
    assert_equal result.blank?, true, "Should result in empty action_handler list"    
  
    config = {:action_handlers => {:appenders => :html}}
    result = config.action_handlers
    assert_equal Tracing::HtmlAppender, result.appenders[0].class, "Should result in action handler with HtmlAppender registered"    
  
    config = {:action_handlers => {:filters => {:i_method_filter => "a,b"}}}
    result = config.action_handlers
    assert_equal Tracing::MethodFilter, result.filters[0].class, "Should result in action handler with MethodFilter registered"    
  
    ah1 = {:filters => {:i_method_filter => "a,b"}, :appenders => :html}
    ah2 = {:filters => {:x_method_filter => "c,d"}, :appenders => :xml}
    
    config = {:action_handlers => [ah1, ah2]}
    result = config.action_handlers
    assert_equal Tracing::MethodFilter, result[0].filters[0].class, "Should result in action handler with MethodFilter registered"    
    assert_equal Tracing::MethodFilter, result[1].filters[0].class, "Should result in action handler with MethodFilter registered"    
  end
  
  def test_create_filter
    config = {:i_method_filter => "a,b"}
    result = config.create_filter
    puts result.inspect
    assert_equal Tracing::MethodFilter, result.class, "Should result in method filter"    

    config = {:filters => {:i_method_filter => "a,b"}}
    result = config.create_filter
    assert_equal Tracing::MethodFilter, result.class, "Should result in method filter"    
  end

  def test_create_filter_hash
    config = {:i_method_filter => "a,b"}
    result = config.create_filter_hash
    exp_result = {:method_filter => { :include => "a,b" } }
    assert_equal exp_result, result, "Should result in :method_filter hash with :include name rules"    
  
    config = {:xy_class_filter => "a,b"}
    result = config.create_filter_hash
    exp_result = {:class_filter => { :exclude_and_yield => "a,b" } }
    assert_equal exp_result, result, "Should result in :class_filter hash with :exclude_and_yield name rules"    
  end
  
  def test_try_create_filter_hash
    config = {:i_method_filter => "a,b"}
    result = config.create_filter_hash
    exp_result = {:method_filter => { :include => "a,b" } }
    assert_equal exp_result, result, "Should result in :method_filter hash with :include name rules"    
  end
  
  def test_filters
    config = {:filters => []}
    result = config.filters
    assert_equal result.blank?, true, "Should result in empty filters list"    
  
    config = {:filters => {:i_method_filter => "a,b"}}
    result = config.filters
    assert_equal Tracing::MethodFilter, result.class, "Should result in method filter"    
    
    puts result.rules.inspect
    expected = {:include => "a,b"}
    assert_equal expected, result.rules, "Should result in method rules"    
  end
    
end

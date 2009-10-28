# my_instance_variables = {:template_path => 'taglibs/rapid_core.dryml'}
# args = {:a => 7}
# context = {
#   :modules => cls_name.modules,
#   :class_name => cls_name.class_name,
#   :full_class_name => cls_name,
#   :method_name => name,
#   :args => args,
#   :block => false,
#   :vars => my_instance_variables # to carry @template_path etc.
# } 

Module_filter_A = {
  :name => 'my modules',
  :module_rules => [{
    # id of modules rule set
    :name => ['my_modules'],
    :include => [/Al/],
    :exclude => [/Be/],
    :default => true
  }
]}

Class_filter_A = {
  :name => 'my classes',  
  :class_rules => [{
    # id of class rule set
    :name => 'my_classes',
    :include => [/MyCl/],
    :exclude => [/NotMy/],
    :include_and_yield => ['blap'],    
    :default => false
  }]
}

Method_filter_A = {
  :name => 'my methods',  
  :method_rules => [{
    # id of method rule set
    :name => 'my_methods',
    :include => [/by.*/, 'compile', 'do_it'],
    :exclude => ['my.*'],
    :exclude_and_yield => ['blip'],
    :default => false
  }]
}

Class_composite_filter_A = {
  # id of composite rule set  
  :name => 'Template stuff',
  :classes => [{
    :names => ['My', /My/],
    :method_rules => {
      :include => [/by.*/, 'DRYMLBuilder'],
      :exclude => ['Taglib'],
      :default => false
    }
  }]
}

Module_composite_filter_A = {
  # id of composite rule set    
  :name => 'dryml_filter',
  :modules => [{
    :names => ['Hobo:Dryml', /Dryml/],
    :class_rules => {
      :include => [/Template.*/, 'DRYMLBuilder'],
      :exclude => ['Taglib'],
      :default => true
    },
    :method_rules => {
      :include => [/Template.*/, 'DRYMLBuilder'],
      :exclude => ['Taglib'],
      :default => true
    }
  }]
}


# for specific instance_vars, match on values (after .to_s on var)  
Var_composite_filter_A = {
  :name => 'template_path',
  :vars => [{
    :name => 'template_path', :type => :string,
    :var_rules => {
      :include => [/.*\/taglib\/.*/], 
      :exclude => [/.*\/rapid_.*/]         
    } 
    },
    {
      :name => 'template_path', 
      :var_rules => {
        :exclude => [/.*\/rapid_.*/],         
        :default => true
      } 
    }]
}
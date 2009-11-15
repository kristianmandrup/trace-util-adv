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

Method_filter_hello = {
  :name => 'my methods',  
  :method_rules => [{
    # id of method rule set
    :name => 'my_methods',
    :include => [/hi.*/, 'blip', 'blap'],
    :exclude => ['hello'],
    :default => false
  }]
}

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


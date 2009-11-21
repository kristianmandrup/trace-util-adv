Class_composite_filter_A = {
  # id of composite rule set  
  :name => 'Template stuff',
  :classes => [{
    :names => ['My', /My/],
    :method_rules => {
      :include => [/by.*/, 'DRYMLBuilder'],
      :exclude => ['Taglib'],
      :default => :exclude
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
      :default => :include
    },
    :method_rules => {
      :include => [/Template.*/, 'DRYMLBuilder'],
      :exclude => ['Taglib'],
      :default => :include
    }
  }]
}


# for specific instance_vars, match on values (after .to_s on var)  
Var_composite_filter_A = {
  :name => 'template_path',
  :vars => [
      {
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
          :default => :include
        } 
      }
    ],
    :default => :yield    
}
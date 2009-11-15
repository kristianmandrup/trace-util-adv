module FilterMappings
  
  def self.rules_map
    {
      :module_rules => :module_filter,
      :class_rules => :class_filter,
      :method_rules => :method_filter,        
      :var_rules => :vars_filter,        
      :modules => :composite_module_filter,
      :classes => :composite_class_filter,
      :vars => :composite_vars_filter
    }
  end

  def self.convenience_map
    {
     :module => :module_filter,
     :class => :class_filter,
     :method => :method_filter,
     :variable => :vars_filter,
    }
  end


  def self.defaults
    {
     :module_filter => Tracing::ModuleFilter,
     :class_filter  => Tracing::ClassFilter,
     :method_filter => Tracing::MethodFilter,
     :vars_filter => Tracing::InstanceVarFilter,
     :composite_module_filter => Tracing::CompositeModuleFilter,
     :composite_class_filter => Tracing::CompositeClassFilter,
     :composite_vars_filter => Tracing::CompositeInstanceVarFilter
    }
  end  
end
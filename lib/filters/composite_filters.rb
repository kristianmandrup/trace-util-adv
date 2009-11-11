module Tracing
  class CompositeClassFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    # filter on class names and then methods within those classes
    def allow_action(msg, context)
      # class name of context
      class_name = context[:class_name]
      action = rules[:default] || :yield
      rules[:classes].each do |clazz|
        names=clazz[:names]
        class_name_match = names.matches_any?(class_name)
        next if !class_name_match
        # if name matches rule
        method_filter = MethodFilter.new(clazz)
        action = method_filter.allow_action(msg, context)
        return action if (action == :include || action == :exclude)
      end
      return action
    end
  end

  class CompositeModuleFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    # filter on module names and then on class names and methods within those modules
    def allow_action(msg, context)
      modules_name = context[:full_modules_name]
      action = rules[:default] || :yield 
      # puts "modules_name: #{modules_name}"     
      rules[:modules].each do |_module|
        # get names of modules to match
        names         = _module[:names]
        class_rules   = _module[:class_rules]
        classes       = _module[:classes]
        method_rules  =_module[:method_rules]
        
        class_name    = context[:class_name]
        method_name    = context[:method_name]
        
        # puts "module names to match: #{names}"
        # puts "context class_name: #{class_name}"
        # puts "context method_name: #{method_name}"
        
        # test if current module name matches any of the module names for this rule
        next if !names.matches_any?(modules_name)
        # if name matches rule
        if classes && !class_name.blank?
          # puts "CC filter"
          composite_class_filter = CompositeClassFilter.new(_module)
          action = composite_class_filter.allow_action(msg, context)
          return action if (action == :include || action == :exclude)          
        end
        if class_rules && !class_name.blank?
          # puts "class filter"          
          class_filter = ClassFilter.new(_module)
          action = class_filter.allow_action(msg, context)
          return action if (action == :include || action == :exclude)                    
        end
        if method_rules && !method_name.blank?
          # puts "method filter"                    
          method_filter = MethodFilter.new(_module)
          action = method_filter.allow_action(msg, context)
          return action if (action == :include || action == :exclude)
        end
      end
      # puts "action: #{action}"
      return action
    end
  end

  class CompositeInstanceVarFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    def allow_action(msg, context)
      action = rules[:default] || :yield      
      var_rules = rules[:vars]
      # puts "var rules: #{var_rules.inspect}"
      # puts "var_rules size: #{var_rules.size}"
      # puts "context: #{context.inspect}"
      var_rules.each do |var_rule|
        # puts "var rule: #{var_rule.inspect}"
        options = {}
        options[:var_rules] = var_rule[:var_rules]
        options[:var_name]  = var_rule[:name]      
        
        var_filter = InstanceVarFilter.new(options)
        action = var_filter.allow_action(msg, context)
        return action if (action == :include || action == :exclude)        
      end
      return action
    end
  end

end
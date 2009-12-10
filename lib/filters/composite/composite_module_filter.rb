module Tracing
  class CompositeModuleFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    # filter on module names and then on class names and methods within those modules
    def allow_action(msg, context)
      # puts "CM"
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
end
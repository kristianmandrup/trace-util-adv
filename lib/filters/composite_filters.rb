module Tracing
  class CompositeClassFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    # filter on class names and then methods within those classes
    def allow?(msg, context)
      # class name of context
      class_name = context[:class_name]
      rules[:classes].each do |clazz|
        names=clazz[:names]
        next if !names.matches_any?(name)
        # if name matches rule
        method_filter = MethodFilter.new(clazz)
        return false if !method_filter.allow?(msg, context)
      end
      return true
    end
  end

  class CompositeModuleFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    # filter on module names and then on class names and methods within those modules
    def allow?(msg, context)
      modules_name = context[:full_module_name]
      rules[:modules].each do |_module|
        # get names of modules to match
        names = _module[:names]
        # test if current module name matches any of the module names for this rule
        next if !names.matches_any?(modules_name)
        # if name matches rule
        if _module[:classes]
          composite_class_filter = CompositeClassFilter.new(_module)
          return false if !composite_class_filter.allow?(msg, context)
        end
        if _module[:class_rules]
          class_filter = ClassFilter.new(_module)
          return false if !class_filter.allow?(msg, context)
        end
        if _module[:method_rules]
          method_filter = MethodFilter.new(_module)
          return false if !method_filter.allow?(msg, context)
        end
      end
      # log it!
      true
    end
  end

  class CompositeInstanceVarFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    def allow?(msg, context)
      rules[:vars].each do |var|
        var_filter = InstanceVarFilter.new(var)
        return false if !var_filter.allow?(msg, context)
      end
      true
    end
  end

end
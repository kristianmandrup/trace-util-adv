module Tracing
  class CompositeClassFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    # filter on class names and then methods within those classes
    def allow_action(msg, context)
      # puts "CC"
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
end
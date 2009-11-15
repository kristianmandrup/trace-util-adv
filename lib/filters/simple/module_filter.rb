module Tracing
  # filter on module
  class ModuleFilter < BaseFilter
    def initialize(options)
      super(options)
      @rules = options[:module_rules] || {}
    end

    def allow_action(msg, context)
      name = context[:full_modules_name]
      allow = name_allow_action(name)
    end
  end
end  
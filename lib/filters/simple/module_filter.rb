module Tracing
  # filter on module
  class ModuleFilter < BaseFilter
    def initialize(options)
      super(options)
      @rules = options[:module_rules] || options[:module_filter] || {}
    end

    def allow_action(msg, context)
      # puts "ModuleF"
      name = context[:full_modules_name]
      # puts "name: #{name}"
      name_allow_action(name)
    end
  end
end  


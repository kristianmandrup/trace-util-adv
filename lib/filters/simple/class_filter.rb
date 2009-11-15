module Tracing
  # filter on class name
  class ClassFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options[:class_rules] || {}
    end

    def allow_action(msg, context)
      name = context[:class_name]
      # puts "class_name: #{name}"
      allow = name_allow_action(name)
    end
  end
end  
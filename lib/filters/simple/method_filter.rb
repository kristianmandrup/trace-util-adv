module Tracing
  # filter on method
  class MethodFilter < BaseFilter
    def initialize(options)
      super(options)   
      # puts "Method filter options: #{options.inspect}" 
      # puts "use :method_rules or :method_filter"  
      @rules = options[:method_rules] || options[:method_filter] || {}
    end

    def allow_action(msg, context)
      # puts "MethF"
      name = context[:method_name]
      # puts "allow name?: #{name}"
      allow = name_allow_action(name)
    end
  end
end
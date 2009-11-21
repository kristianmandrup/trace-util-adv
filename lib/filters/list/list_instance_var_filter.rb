module Tracing
  class ListInstanceVarFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options || {}
    end

    def allow_action(msg, context)
      puts "LIF"
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
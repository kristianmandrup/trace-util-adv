module Tracing
  module RuleMatch
    class RuleTypeError < RuntimeError; end  
  
    def matches_any?(name) 
      # puts "matches any: #{name.inspect}"
      self.any? do |rule| 
        # puts "rule:" + rule.inspect
        # puts "against:" + name.inspect
        if rule.kind_of? Regexp
          # match return position of match, or nil if no match
          # here converted into boolean result
          match = !(name =~ rule).nil? 
          # puts "match: #{match}"
          match
        elsif rule.kind_of? String
          match = (name == rule)
          # puts "matches string #{rule}: #{match}"          
          match
        elsif rule.kind_of? Proc
          rule.call(name)
        elsif rule.kind_of? NameFilter
          rule.allow?(name)
        else
          raise RuleTypeError, "Bad rule type: must be Regexp, String, Proc or NameFilter"
        end
      end
    end
  
    def rules_allow_action(name)
      # puts "rules_allow_action: #{name}"
      self.each do |rule|
        res = rule.rule_allow_action(name)
        return :exclude if (res == :exclude)
        return :include if (res == :include)
      end
      # default allow action
      return :yield
    end
  end
end
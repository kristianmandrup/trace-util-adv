module Tracing
  module RuleMatch
    class RuleTypeError < RuntimeError; end  
  
    def matches_any?(name) 
      # puts "matches any: #{name}"
      self.any? do |rule| 
        if rule.kind_of? Regexp
          # match return position of match, or nil if no match
          # here converted into boolean result
          match = (name =~ rule) 
          # puts "matches regexp #{rule}: #{match}"
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
  
    def rules_allow?(name)
      self.each do |rule|
        res = rule.rule_allow?(name)
        return false if res == :exclude
        return true if res == :include
      end
      # default allow action
      return true
    end
  end
end
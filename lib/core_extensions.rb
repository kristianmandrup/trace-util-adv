require 'rule_match'

class String
  def modules
    self.split("::")[0..-2]
  end

  def class_name
    self.split("::")[-1..-1]
  end
  
  def in_module?(module_name)
    modules = self.modules
    modules.include?(module_name)      
  end
end  


class Array
  include Tracing::RuleMatch
  
  def add(obj)
    self << obj
    self.flatten!
  end
end

class Hash
  include Tracing::RuleMatch
  
  def rules_allow?(name)
    return false if !rule_allow?(name)
    true      
  end  
    
  def rule_allow?(name)
    include_rules = self[:include]
    if include_rules && include_rules.size > 0
      res = include_rules.matches_any?(name)
      return true if res
    end
    if self[:exclude]
      return false if self[:exclude].matches_any?(name)
    end
    if !self[:default].nil?
      return self[:default]      
    end
    true
  rescue RuleTypeError
    false    
  end  
end



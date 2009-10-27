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

class Symbol
  def prefix(pre)
    (pre.to_s + self.to_s).to_sym
  end
end

class Hash
  include Tracing::RuleMatch

  def try_create_filter(symbol)
    if has_i(symbol)         
      {symbol => {:include => self[symbol] }}
    elsif has_x(symbol)         
      {symbol => {:exclude => self[symbol] }}
    end
  end
  
  def rules_allow?(name)
    rule_allow?(name)
  end  
    
  # return a symbol, either - :include, :exclude or :none (let next filter decide)  
  def rule_allow?(name)
    include_rules = self[:include]
    if include_rules && include_rules.size > 0
      res = include_rules.matches_any?(name)
      return :include if res
    end
    if self[:exclude]
      return :exclude if self[:exclude].matches_any?(name)
    end
    if !self[:default].nil?
      return self[:default]      
    end
    :none
  rescue RuleTypeError
    :exclude    
  end  
  
protected  
  def has_i(symbol)
    self.has_key?(symbol.prefix('i'))
  end

  def has_x(symbol)
    self.has_key?(symbol.prefix('i'))
  end
  
end



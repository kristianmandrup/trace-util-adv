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
  
  def split_names
    self.split(/\s|,/)
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
    isymbol = has_i(symbol) || has_x(symbol)
    # puts "try_create_filter: " + isymbol.inspect 
    if isymbol   
      filter_names = self[isymbol]
      # puts "filter_names:" + filter_names.inspect
      {symbol => {:include => filter_names}}
    end
  end
  
  def rules_allow_action(name)
    rule_allow_action(name)
  end  
    
  def rule_list(rules)
    if rules.kind_of? String
      rules.split_names 
    else
      rules
    end
  end 
    
  # return a symbol, either - :include, :exclude or :yield (let next filter decide)  
  def rule_allow_action(name)
    include_rules = rule_list(self[:include])
    if include_rules && include_rules.size > 0
      # puts "Rule include"            
      res = include_rules.matches_any?(name)
      return :include if res
    end
    exclude_rules = rule_list(self[:exclude])
    if exclude_rules
      # puts "Rule exclude"      
      return :exclude if exclude_rules.matches_any?(name)
    end
    # puts "Not included or excluded"          
    if !self[:default].nil?
      # puts "Return default: #{self[:default]}"
      return self[:default]      
    end
    # puts "Rule yields"
    return :yield
  rescue RuleTypeError
    # puts "error"
    return :exclude    
  end  
  
protected  
  def has_i(symbol)
    isym = symbol.prefix('i')
    self.has_key?(isym) ? isym : false
  end

  def has_x(symbol)
    self.has_key?(symbol.prefix('i'))
  end
  
end



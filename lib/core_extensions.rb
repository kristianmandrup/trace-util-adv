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

  def self.rule_symbol_mappings
    {
      :i => :include,
      :x => :exclude,
      :iy => :include_and_yield,
      :xy => :exclude_and_yield      
    }
  end

  def try_create_filter(symbol)
    _symbol = has_any_prefix(symbol)
    puts _symbol.inspect
    return if !_symbol
    
    prefix = _symbol[:prefix]
    filter_sym = _symbol[:filter_symbol]
    # 
    filter_names = self[filter_sym]
    # 
    rule_symbol = Hash.rule_symbol_mappings[prefix.to_sym]
    {symbol => {rule_symbol => filter_names}}    
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
  def has_prefix(symbol, prefix)
    sym = symbol.prefix(prefix)
    self.has_key?(sym) ? {:filter_symbol => sym, :prefix => prefix} : false
  end

  def has_any_prefix(symbol)
    ['iy', 'xy', 'i', 'x'].each do |prefix|
      hash_result = has_prefix(symbol, prefix)
      return hash_result if hash_result         
    end  
    false
  end

  
end



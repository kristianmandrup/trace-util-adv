require 'rules/rule_match'

class Hash
  include Tracing::RuleMatch
  
  def rules_allow_action(name)
    rule_allow_action(name)
  end  
    
  def rule_list
    rules
  end 
    
  # return a symbol, either - :include, :exclude or :exclude_and_yield, :include_and_yield or :yield (let next filter decide)  
  def rule_allow_action(name)
    include_rules = self[:include].rule_list
    if !include_rules.blank?
      # puts "Rule include"            
      res = include_rules.matches_any?(name)
      return :include if res
    end
    exclude_rules = self[:exclude].rule_list
    if !exclude_rules.blank?
      # puts "Rule exclude"      
      return :exclude if exclude_rules.matches_any?(name)
    end

    rules = self[:exclude_and_yield].rule_list
    if !rules.blank?
      # puts "Rule exclude"      
      return :exclude_and_yield if rules.matches_any?(name)
    end

    rules = self[:include_and_yield].rule_list
    if !rules.blank?
      # puts "Rule exclude"      
      return :include_and_yield if rules.matches_any?(name)
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
end
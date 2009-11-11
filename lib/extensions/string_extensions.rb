class String
  def modules
    self.split("::")[0..-2]
  end

  def class_name
    name = self.split("::")[-1..-1]
    name = name[0] if name.kind_of? Array 
    name
  end
  
  def in_module?(module_name)
    modules = self.modules
    modules.include?(module_name)      
  end
  
  def rule_list  
    self.split_names 
  end
  
  def split_names
    if self.include?(",")
      s = self.gsub(/\s/, '')
      s.split(",") if s
    else
      self.split(" ")
    end
  end
  
  # return name matching rules as array
  # split " ", ","
  def rules
  end
  
end  

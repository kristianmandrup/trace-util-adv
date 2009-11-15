class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
  
  def rule_list
    self
  end

  def appenders
    self
  end

  def filters
    self
  end
  
end


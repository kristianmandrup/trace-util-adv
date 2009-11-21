class Symbol
  def prefix(pre)
    (pre.to_s + '_' + self.to_s).to_sym
  end

  def filter_class
    mapper = FilterMappings.defaults
    mapper.map(self)
  end
  
  def trace_class
    mapper = TemplateMappings.defaults
    mapper.map(self)
  end
  
  def appender_class
    mapper = AppenderMappings.defaults
    mapper.map(self)  
  end
  
  def rule
    mapper = RuleMappings.prefix_map
    mapper.map(self)  
  end
  
  def appenders
    puts "Appenders from: #{self.inspect}"
    puts "appender_class: #{self.appender_class.inspect}"
    self.appender_class.new nil
  end
  
end

class Symbol
  def prefix(pre)
    (pre.to_s + '_' + self.to_s).to_sym
  end

  def filter_class
    mapper = Mappings.default_filters
    mapper.map(self)
  end
  
  def trace_class
    mapper = Mappings::default_tracer_mappings
    mapper.map(self)
  end
  
  def appender_class
    mapper = Mappings::default_appender_mappings
    mapper.map(self)  
  end
  
  def rule
    mapper = Mappings::rule_symbol_mappings
    mapper.map(self)  
  end
  
  def appenders
    self.appender_class.new
  end
  
end

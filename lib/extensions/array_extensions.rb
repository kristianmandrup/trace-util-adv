class Array
  include Tracing::RuleMatch
    
  def add(obj)
    self << obj
    self.flatten!
    self.compact! if self
  end
    
  def rule_list
    self
  end
      
  # iterate and return filters array
  def filters
    _filters = []
    self.each do |_filter|
      _filters.add(_filter.filters)
    end
    _filters                    
  end

  # iterate and return action_handlers array
  def action_handlers
    _action_handlers = []
    self.each do |_action_handler|
      _action_handlers.add(_action_handler.action_handlers)
    end
    _action_handlers                
  end

  # iterate and return action_handlers array
  def appenders
    _appenders = []
    self.each do |_appender|
      _appenders.add(_appender.appenders)
    end
    _appenders        
  end
  
  
end

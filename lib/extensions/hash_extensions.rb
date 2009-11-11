require 'action_handler/action_handler'

class Hash
  
  def set_context(hash)
    modules = hash[:modules]
    cls_name = hash[:class_name]
    method_name = hash[:method_name]
    args = hash[:args]
    vars = hash[:vars]
    self[:modules] = cls_name.modules if cls_name
    self[:modules] = modules if modules

    self[:class_name] = cls_name.class_name if cls_name
    self[:method_name] = method_name if method_name
    self[:args] = args if args
    self[:vars] = vars if vars


    self[:full_modules_name] = full_modules_name
    self[:full_class_name] = full_class_name
    self[:full_method_name] = full_method_name    
  end

  def full_modules_name
    self[:modules].join("::") if self[:modules]
  end

  def full_class_name
    mod_name = self.full_modules_name
    name = self[:class_name]
    name = "#{mod_name}::#{name}" if !mod_name.blank?
  end

  def full_method_name
    cls_name = self.full_class_name
    name = self[:method_name]
    name = "#{cls_name}.#{name}" if !cls_name.blank?
  end


  def configuration
    Tracing::Configuration.new(self)
  end
  
  def final_yield_action
    self[:final_yield_action] || :include
  end
  
  # return filter
  def filters
    filter_list = self[:filters]  
    # puts "filter_list: #{filter_list.inspect}"  
    if filter_list
      filter_list.filters              
    else
      # puts "create filter from: #{self.inspect}"
      x = self.create_filter
      # puts "created filter: #{x.inspect}"
      x
    end        
  end

  # return action_handler
  def action_handlers
    action_handler_list = self[:action_handlers]
    if action_handler_list
      action_handler_list.action_handlers        
    else
      Tracing::ActionHandler.new(self)
    end
  end

  # return action_handler
  def appenders        
    appender_list = self[:appenders]
    appender_list.appenders
  end

  # return tracer
  def tracer     
    tracer_key = self[:tracer]
    tracer_class = Mappings.default_tracer_mappings[tracer_key]   
    tracer_class.new
  end
    
  def create_filter
    return self.filters if self[:filters]
    hash = self.create_filter_hash || self    
    if hash    
      filter_class = hash.filter_class
      # puts "hash: #{hash.inspect} -> class: #{filter_class}"
      return filter_class.new(hash) if filter_class
    end
    nil    
  end  

  def create_filter_hash
  # puts "TRY create_filter: " + name_hash.inspect
    [:module_filter, :class_filter, :method_filter, :vars_filter].each do |symbol|
      # puts "symbol:" + symbol.to_s
      res = self.try_create_filter_hash(symbol) 
      # puts "Filter created:" + res.inspect     
      return res if res
    end
    # puts "no filter could be created :("
    nil
  end    

  def try_create_filter_hash(symbol)
    _symbol = has_any_prefix(symbol)
    puts _symbol.inspect
    return if !_symbol
    
    prefix = _symbol[:prefix]
    filter_sym = _symbol[:filter_symbol]
    # 
    filter_names = self[filter_sym]
    # 
    rule_symbol = prefix.to_sym.rule
    {symbol => {rule_symbol => filter_names}}    
  end

  def map(key)
    clazz = self[key]
    return clazz if clazz
    self[:default]
  end

  def filter_class
    Mappings.convenience_map.select do |key, _filter|
      return _filter.filter_class if self.has_key?(key) || self.has_key?(_filter)
    end
    Mappings.filter_rule_mappings.select do |key, _filter|
      return _filter.filter_class if self.has_key? key
    end
    nil
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




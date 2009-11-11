require 'extensions/hash_extensions'
require 'extensions/array_extensions'
require 'extensions/string_extensions'
require 'extensions/symbol_extensions'
require 'extensions/nilclass_extensions'

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


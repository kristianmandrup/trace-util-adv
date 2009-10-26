require 'core_extensions'
require 'filters/base_filters'
require 'filters/message_filters'

# Procs of this form can be used as filters inside include/exclude lists
rest_view = Proc.new {|name| name == 'abc' }

module Tracing  
  # abstract context filter
  class MsgContextFilter
    attr_accessor :options    
    
    def initialize(options)
      @options = options
    end
  
    def allow?(msg, context)
      true
    end
  end

  # abstract name filter
  class NameFilter 
    attr_accessor :options

    def initialize(options)
      @options = options
    end
    
    # return boolean
    def allow?(name)
      true
    end
  end

  class CustomNameFilter < NameFilter 
    def allow?(name)
      name == options[:name]
    end    
  end
end

msg_filter = Tracing::MsgContextFilter.new '22'

name_filter = Tracing::CustomNameFilter.new('rapid')

var_rule_A = {
  :name => 'var rule A',
  :var_name => :template_path,
  :var_rules => {
    :include => [rest_view, name_filter], 
    :exclude => [/.*\/rapid_.*/],
    :default => false         
  }
}

comp_var_rules_A = {
  :name => 'test template_path',
  :vars => [var_rule_A]
}

cls_name = "Alpha::Beta::Gamma"
name = "my_method"
my_instance_variables = {:template_path => 'taglibs/rapid_core.dryml'}
args = {:a => 7}
@context = {
  :modules => cls_name.modules,
  :class_name => cls_name.class_name,
  :full_class_name => cls_name,
  :method_name => name,
  :args => args,
  :block => false,
  :vars => my_instance_variables # to carry @template_path etc.
}

var_filter = Tracing::InstanceVarFilter.new(var_rule_A)

puts var_filter.allow?("hello", @context)
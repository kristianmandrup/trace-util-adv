require 'include'

module Context
  def self.ctx1
    cls_name = "Alpha::Beta::Gamma"
    name = "my_method"
    my_instance_variables = {:template_path => 'taglibs/rapid_core.dryml'}
    args = {:a => 7}
    {  :class_name => cls_name, :method_name => name, :args => args, :block => false, :vars => my_instance_variables }.context            
  end
end

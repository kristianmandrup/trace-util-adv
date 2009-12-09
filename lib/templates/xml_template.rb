module Tracing 
  class XmlTemplate < BaseTemplate
    def before_template(context)
      template = <<-EOF
    <method name="<%= context[:method_full_name] %>">
      <modules><%= context[:full_module_name] %></modules>
      <class><%= context[:class_name] %></class>
      <args><%= context[:args].inspect if context[:args]%></args>
      #block#
    EOF
    end

    def before_block_template 
      template = <<-EOF
    <block-arg>true</block-arg>
    EOF
    end

    def end_template(context) 
      template = <<-EOF
      <result><%= context[:result] %></result>
    </method>
    EOF
    end

    # override
    def handle_before_call(context)
      template = before_template(context)
      block_replace = context[:block] ? before_block_template : ""
      template.gsub!(/#block#/, block_replace)
      output(template, context)
    end
  end
end
module Tracing 
  class HtmlTemplate < BaseTemplate
      
    def before_template(context)
      # method_name = context[:method_full_name]
      # args = context[:args].inspect
      template = <<-EOF
      <div class="method-title"><%= context[:method_full_name] %></div>
      <div class="method-body">
        <div class="begin">
          <div class="method-name"><%= context[:method_full_name] %> :: BEGIN</div>
          <div class="args">
            <div class="method-args"><%= context[:args] %> </div>
            #block#
          </div>
        </div>
    EOF
    end

    def before_block_template 
      template = <<-EOF
    <div class="method block-arg">(and a block)</div>
    EOF
    end

    def end_template(context) 
      # method_name = context[:method_full_name]
      # result = context[:result].inspect
      template = <<-EOF
        <div class="end">
          <div class="method-name"><%= context[:method_full_name] %> :: END</div>
          <div class="method-result"><%= context[:result] %></div>
        </div>
      </div>
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
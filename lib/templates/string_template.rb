module Tracing 
  class StringTemplate < BaseTemplate
    def before_template(context)
      template = <<-EOF
    <<= <%= context[:method_full_name] %> : BEGIN
    -----------------------------------------------
    <%= context[:args].inspect if context[:args] %>
    ===============================================
    EOF
    end

    def before_block_template 
      template = <<-EOF
    (and a block)
    -----------------------------------------------
    EOF
    end

    def end_template(context) 
      template = <<-EOF
    <<= <%= context[:method_full_name] %> : END
    -----------------------------------------------
    <%= context[:result] %>
    ===============================================
    EOF
    end  
  end
end
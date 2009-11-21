require 'templates/trace_output_handler'

module Tracing 
  class BaseTemplate
    include Tracing::OutputHandler
      
    def handle_after_call(context)
      template = end_template(context)
      output(template, context)              
    end

    def handle_before_call(context)
      template = before_template(context)
      if context[:block]       
        template << before_block_template
      end
      output(template, context)
    end  
  end
end


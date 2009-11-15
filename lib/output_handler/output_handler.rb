module Tracing
  module OutputHandler   

    # TODO: refactor (duplicate of appender method)
    def method_stack
      @method_stack ||= []
    end
    
    # override to increase # of spaces for each indenation level!
    def space_count
      1
    end

    # calculate indentation level, based on method stack level (# of nested method calls)
    def indentation
      s = ""
      lv = method_stack.empty? ? 0 : method_stack.size-1 
      lv.times { s << (" " * space_count) }
      s
    end

    def output(template, context)
      # get spaces to indent each line
      spaces = indentation

      # modify template, inserting indentation
      lines = template.split("\n")
      lines.map!{|line| spaces + line + "\n"}
      template = lines.join

      # send modified template to output handler with context
      output_handler(template, context)
    end

    # default output action: put string to STDOUT
    # override this to customize trace handling
    def output_handler(template, context)
      # create new erb template
      erb_template = ERB.new template
      
      # evaluate erb template for output using context
      str_res = erb_template.result(binding)
      # send final output to action handlers for further processing...
      # action_handlers(str_res, context)
    end
  end 
end
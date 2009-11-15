module Tracing 
  class TemplateLogAppender < FileAppender  

    def initialize(init_options)
      @tracer = Tracing::OutputTemplate::StringTrace.new
      super(init_options)
    end

    # get template path
    def template_path(context)
      obj = context[:self]
      template_path = obj.instance_variable_get :@template_path    
    end
  
    # perform append
    def allow_append(lines, context)
      path = template_path(context)
      if path
        log_file =  + '.log'
        write_file(log_file)
      end
    end

    # silently ignore
    def not_allow_append(lines, context)
    end
  end
end
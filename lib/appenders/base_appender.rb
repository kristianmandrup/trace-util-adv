module Tracing
  # base appender (abstract)
  class BaseAppender
    include Tracing::FilterUse

    attr_accessor :options
    attr_reader :templates
    
    class << self
      attr_accessor :templates


      def register_templates(templates = nil)
        @templates ||= {} # default_templates
        @templates = @templates.merge!(templates || {})
      end
      
      def create_template(template)
        templates ||= register_templates
        if template.kind_of?(Symbol) || template.kind_of?(String)
          template_class = templates[template.to_sym] || templates[:default]
          template_class.new
        elsif template.kind_of? Tracing::BaseTemplate
          template
        else
          nil
        end
      end      
    end

    def initialize(init_options = nil)          
      return if !init_options
      if init_options.kind_of? Hash
        @options = init_options[:options] || init_options
        register_filters(init_options[:filters])
        template = @options[:template] if @options
        return if !template

        @template = self.class.create_template(template)      
      elsif init_options.kind_of? Symbol
        self.class.register_templates
        tracer = self.class.templates[init_options]
        return if !tracer

        @template = self.class.create_template(template)
      else
        raise Exception, "Appender must be initialized with Hash"
      end
    end 
  
    # default action handler depending on filters result 
    def handle(txt, context)
      if filters_allow?(txt, context)
        allow_append(txt, context)
      else
        not_allow_append(txt, context)
      end
    end
  
    def allow_append(txt, context)  
          
    end

    def not_allow_append(txt, context)
    end

    def time_limit
      options[:time_limit] || 1.minute    
    end
  end
end  
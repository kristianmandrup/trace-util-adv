require "core_extensions"
require "trace_calls"
require "output_templates"
require "sample_filters"
require "rubygems"
require "duration"
require "test/unit"

# configure use of TraceExt
module Me
  class My     

    def hello
      puts "Hello cruel World!"
    end   

    def hi_there
      puts "Hello cruel World!"
    end   

    def blip
      puts "Blip!"
    end   

    def blap
      puts "Blap!"
    end   

  end    
end

Method_filter_hello = {
  :name => 'my methods',  
  :method_rules => [{
    # id of method rule set
    :name => 'my_methods',
    :include => [/hi.*/, 'blip', 'blap'],
    :exclude => ['hello'],
    :default => false
  }]
}    
 
  
class TestFilter < Test::Unit::TestCase

  attr_reader :ah1, :filters

  def setup
    # module filter is created (see sample filters)
    # @module_filter = Tracing::ModuleFilter.new(Module_filter_A)        

    # Appender is configured with some appender options and a Tracer
    # string_tracer = Tracing::OutputTemplate::StringTrace.new        
    # template_log_options = {:options => {:overwrite => false, :time_limit => 2.minutes}, :tracer => string_tracer}
    # tla1 = Tracing::TemplateLogAppender.new(:options => {:overwrite => false, :time_limit => 2.minutes}, :tracer => :string)  
    
    # action handler is configured with a set of filters and a set of appenders
    # the appenders are called in turn if log statement passes all filters!
    @ah1 = Tracing::ActionHandler.new(:filters => @filters = [Module_filter_A, Method_filter_A], :appenders => :logger)    

    appender_options = {:options => {:overwrite => false, :time_limit => 2.minutes}, :type => :logger, :tracer => :string}

    # @ah2 = Tracing::ActionHandler.new(:filters => @filters = [Module_filter_A, Method_filter_A], :appenders => appender_options)    

    # TraceExt is configured with a set of action handlers
    # on any method call the set of action handlers are called if all initial filters are passed 
    # Tracing::TraceExt.register_action_handlers([ah1])
  end

  def teardown
    ## Nothing really
  end
            
  def test_filter
    # module_filter = Tracing::ModuleFilter.new(Module_filter_A)   
    
    # TraceExt can be configured with a set of 'initial' filters, that determine if the method should have theaspects applied at all     
    # Tracing::TraceExt.register_filters([module_filter])
    # , :filters => Class_filter_A     
    # Tracing::TraceExt.configure(:action_handlers => [ah1])
    # Tracing::TraceExt.configure(:appenders => :logger)
    
    dryml_classes_to_trace = [ 'My']

    dryml_classes_to_trace.each do |cls|
      str = "Me::#{cls}.class_eval { include Tracing::TraceCalls }"
      puts str
      eval str
    end    
    
    # Me::My.class_eval { include Tracing::TraceCalls }
        
    Tracing::HtmlAppender.default_path = 'log_files/html'
        
    # Tracing::TraceExt.configure(:appenders => {:type => :html, :to_file => 'log_files/html/traced.html'})    
    Tracing::TraceExt.configure(:type => :html, :to_file => 'traced4.html', :filters => Method_filter_hello)        
        
    # Tracing::TraceExt.configure(:filters => Class_filter_A)
    # 
    my = Me::My.new
    my.hello
    my.hi_there
    my.blip
    my.blap

    
    # my.action_handlers(['a', 'b'], context)           
  end
  
  
end


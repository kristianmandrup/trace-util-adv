require "core_extensions"
require "trace_calls"
require "output_templates"
require "sample_filters"
require "rubygems"
require "duration"
require "test/unit"
 
class TestStreamAppender < Test::Unit::TestCase

  attr_reader :ah1, :filters

  def setup
    @stream_app = {:tracer => :stream, :stream => :out}      
  end
        
  def test_filter
    context = Testing.default_context
    
    @ah1.allow_append("BEGIN #{name}", @context)

    name = "my_other_method"
    context.method_name = name

    @ah1.allow_append("BEGIN #{name}", @context)        
    
    context.result = "32"

    @ah1.allow_append("END #{name}", @context)    

    name = "my_method"
    context.method_name = name
        
    context.result = "27"

    @ah1.allow_append("END #{name}", @context)    
  end
  
  
end


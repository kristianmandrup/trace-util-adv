require "core_extensions"
require "trace_calls"
require "output_templates"
require "rubygems"
require "duration"
require "test/unit"
 
class TestFilter < Test::Unit::TestCase

  def teardown
    ## Nothing really
  end
    
  def test_filter_create

    names = %w{blip blop}
    puts "create include method filter, names: #{names}" 
    method_filter_B = Tracing::Filter.create_filter({:imethod_filter =>  names})
    
    f = Tracing::BaseFilter.create_filter(method_filter_B)
    
    puts method_filter_B.inspect
    puts f.inspect
  end
  
  
end


require "include"
require 'appender_test_case'

class TestStreamAppender < Test::Unit::TestCase
  include AppenderTestCase

  def setup
    # Tracing::Appender.register_default_mappings    
    
    # test all the ways an appender can be initialized!
    @appender = {:appender => :stream, :stream => :stdout }.appender
    @ctx = Context.ctx1
  end
            
end


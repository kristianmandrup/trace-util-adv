require "include"
require 'appender_test_case'

class TestXmlAppender < Test::Unit::TestCase
  include AppenderTestCase

  def setup
    @appender = {:appender => :xml, :to_file => 'log_files/xml/traced.xml'}.appender
  end  
  
end


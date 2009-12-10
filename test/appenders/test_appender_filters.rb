require "include"


class TestAppenderFilters < Test::Unit::TestCase

  def setup
    # Trace filters
    im_filter_1 = {:i_method_filter => "a,b"}
    xym_class_1 = {:xy_class_filter => "C,D"}
    @filters = [im_filter_1, xym_class_1]

    @app_filter_1 = {:x_class_filter => "Dryml"}
    @app_filter_2 = {:i_class_filter => "Template"}
    
    @filters = [@app_filter_1, @app_filter_2]
  end
  
  def test_appender_filters
    # Trace configuration    
    
    appender_1 = {:appender => :xml, :filters => @filters}.appender
    puts "Appender 1: #{appender_1}"
    assert_equal Tracing::XmlAppender, appender_1.class, "Should create instance of XmlAppender"
  end
  
end
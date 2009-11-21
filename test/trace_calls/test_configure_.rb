require "include"

class TestTraceCallsConfigure < Test::Unit::TestCase
  
  def setup
    # Trace filters
    im_filter_1 = {:i_method_filter => "a,b"}
    xym_class_1 = {:xy_class_filter => "C,D"}
    @filters = [im_filter_1, xym_class_1]
    
    @ah1_filter_1 = {:x_class_filter => "Dryml"}
    @ah1_filter_1 = {:i_class_filter => "Template"}
    
    @ah_filters = [@ah1_filter_1, @ah1_filter_2]
    
    @ah1_app_1 = :xml
    @ah1_app2 = :html
    
    @appenders = [@ah1_app_1, @ah1_app2]
  end


  def test_register_action_handler_from_hash
    # Action handler
    ah1 = {:filters => @ah_filters, :appenders => @appenders}.action_handlers
    action_handlers = ah1
    # Trace configuration
    configuration = Tracing::Configuration.new :action_handlers => action_handlers, :filters => @filters, :final_yield_action => :exclude
    # configure
    TraceCalls.configure(configuration)
  end

  def test_register_action_handler_from_hash
    # Action handlers
    ah1 = {:filters => @filters}.action_handlers     
    app_1 = :xml
    # Trace configuration
    configuration = Tracing::Configuration.new :appenders => app_1, :filters => @ah_filters, :final_yield_action => :exclude

    # configure
    Tracing::TraceExt.configure(configuration)

  end


  def test_register_action_handler
  end


  def test_register_multiple_action_handlers
  end

  def test_register_multiple_action_handler_from_hash
    # Action handlers
    ah1 = {:filters => @ah_filters, :appenders => @appenders}
    ah2 = {:filters => @ah_filters, :appenders => @appenders}

    action_handlers = [ah1, ah2]

    # Trace filters
    im_filter_1 = {:i_method_filter => "a,b"}
    xym_class_1 = {:xy_class_filter => "C,D"}
    filters = [im_filter_1, xym_class_1]

    # Trace configuration
    configuration = Tracing::Configuration.new :action_handlers => action_handlers, :filters => @ah_filters, :final_yield_action => :exclude

    # configure
    Tracing::TraceExt.configure(configuration)
  end

end


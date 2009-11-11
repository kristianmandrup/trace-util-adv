# Action handlers
ah1 = {:filters => [ah1_filter_1, ah1_filter_2], :appenders => [ah1_app_1, ah1_app2]}
ah2 = {:filters => [ah2_filter_1, ah2_filter_2], :appenders => [ah2_app_1, ah2_app2]}

action_handlers = [ah1, ah2]

# Trace filters
im_filter_1 = {:i_method_filter => "a,b"}
xym_class_1 = {:xy_class_filter => "C,D"}
filters = [im_filter_1, xym_class_1]

# Trace configuration
configuration = Tracing::Configuration.new {:action_handlers => action_handlers, :filters => filters, :final_yield_action => :exclude}

# configure
TraceCalls.configure(configuration)
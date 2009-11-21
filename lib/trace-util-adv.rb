require 'rubygems'
require 'duration'
require 'require-magic'
Require.base_path = File.dirname(__FILE__)
Require.rfolder 'rules'
Require.folder 'extensions'
require 'filters/include'
Require.folder 'output_handler'
require 'appenders/include'
Require.rfolder('action_handler')
Require.rfolder('targets')
Require.rfolder('templates')
Require.folder('trace_calls')


# Module_filter = {
#   :name => 'my modules',
#   :default => :exclude,
#   :module_rules => [{
#     # id of modules rule set
#     :name => ['my_modules'],
#     :include => [/Hobo/],
#     :exclude => [/Dryml/],
#     :default => :exclude
#   }]
# }
# 
#   _filter = Module_filter
# 
#   context = {:modules => ['Blip', 'Blap']}.context
#   
#   puts context.inspect
# 
#   options = {:filters => _filter}    
#   exec = Tracing::Filter::Executor.new(options)       
#   result = exec.filters_allow?('msg', context)
# 
#   puts "Result:" + result.inspect  
# 
#   assert_equal false, result, "Filter should NOT allow passage"    

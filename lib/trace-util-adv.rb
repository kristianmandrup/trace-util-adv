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

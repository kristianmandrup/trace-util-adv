require 'erb'
Dir.glob(File.join(File.dirname(__FILE__), '**/*.rb')).each {|f| require f }
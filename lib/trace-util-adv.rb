require 'rubygems'
require 'duration'

def include_folder_rec(name)
  Dir.glob(File.join(File.dirname(__FILE__), "#{name}/**/*.rb")).each {|f| 
    puts f
    require f 
  }
end

def include_folder(name)
  Dir.glob(File.join(File.dirname(__FILE__), "#{name}/*.rb")).each {|f| 
    puts f
    require f 
  }
end

include_folder_rec('rules')
include_folder_rec('extensions')
require 'filters/include'
include_folder('output_handler')
require 'appenders/include'
include_folder_rec('action_handlers')
include_folder_rec('targets')

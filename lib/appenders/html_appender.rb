# surround html ouput with wrapper-html
# include jquery and css
# collapse non-important regions and expand important ones

# TODO: how to ensure html ouput finishes
# file.seek(-20, IO:SEEK_END)
module Tracing 
  class HtmlAppender < FileAppender   
    attr_accessor :to_file, :html_output

    class << self
      def default_path
        return if !@default_path
        if !File.exists?(@default_path)
          FileUtils.mkdir_p @default_path
        end
        @default_path
      end
            
      def default_path=(path)
        @default_path = path
      end
    end    

    def initialize(init_options = nil)
      @tracer = Tracing::OutputTemplate::HtmlTrace.new      
      super(init_options)  
      @html_output = html_begin 

      return if !init_options
      # write to file
      @to_file = init_options[:to_file]  
      if @to_file    
        write_wrap_file(to_file)
      else
        html_output << html_begin << html_end
      end
    end

    def write_wrap_file(file)
      file = file_path(file)
      File.open(file, "w") do |file|
        file.puts html_begin
        file.puts html_end
      end
    end

    def create_initial_file(file)
      write_wrap_file(file)      
    end

    def html_begin
      %q{<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
  <title>Tracing :: abc</title>
  <link rel="stylesheet" href="tracing.css" type="text/css" media="screen" title="tracing" charset="utf-8">
  <script type="text/javascript" src="jquery-1.3.2.min.js"></script>
  <script type="text/javascript" src="tracing.js"></script> 
</head>
<body>}
    end
  
    def html_end
      %q{
</body>
</html> 
      }
    end
  
    # perform append
    # perform append
    def allow_append(txt, context)            
      # check if BEGIN or END
      if txt.include?('BEGIN')
        txt = tracer.handle_before_call(context)
      elsif txt.include?('END')
        txt = tracer.handle_after_call(context)
      end
      
      if to_file                   
        insert_into_file(to_file, txt, html_end) 
      else
        # insert into string
        html_output = txt[0..-html_end.length] + txt + html_end 
      end
    end

    # silently ignore
    def not_allow_append(lines, context)
    end
  end
end
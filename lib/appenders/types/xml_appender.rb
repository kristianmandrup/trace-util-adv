# append log to xml-stream or file
module Tracing 
  class XmlAppender < FileAppender   
    attr_accessor :xml_output, :to_file

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
      @tracer = Tracing::XmlTemplate.new      
      super(init_options)  
      @xml_output = xml_begin    
      
      return if !init_options      
      # write to file
      @to_file = init_options[:to_file]
      if @to_file    
        write_wrap_file(to_file)
      else
        xml_output << xml_begin << xml_end
      end
    end

    def create_initial_file(file)
      write_wrap_file(file)      
    end

    def write_wrap_file(file) 
      file = file_path(file)      

      dir = File.dirname(file)      
      FileUtils.mkdir_p dir if !File.directory? dir
      
      File.open(file, "w") do |file|
        file.puts xml_begin
        file.puts xml_end
      end
    end

    def xml_begin
      "<?xml version='1.0' encoding='UTF-8'?>\n<tracing>\n"
    end
  
    def xml_end
      "</tracing>"
    end
  
    # perform append
    def allow_append(txt, context)            
      # check if BEGIN or END
      if txt.include?('BEGIN')
        txt = tracer.handle_before_call(context)
      elsif txt.include?('END')
        txt = tracer.handle_after_call(context)
      end
      
      if to_file                   
        insert_into_file(to_file, txt, xml_end) 
      else
        # insert into string
        xml_output = xml_output[0..-xml_end.length] + txt + xml_end 
      end
    end

    # silently ignore
    def not_allow_append(lines, context)
    end
  end
end
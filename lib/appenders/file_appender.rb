module Tracing
  module DefaultPath
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
end  


module Tracing
  # File Appender
  class FileAppender < BaseAppender
    include Tracing::DefaultPath
    class << self
      include Tracing::DefaultPath
    end    

    # file
    def write_file(file, txt)
      file = file_path(file)      
      
      write_mode = mode(file) 
      File.open(file, write_mode) do |f|
        f.puts txt
      end   
    end

    def create_initial_file(file)
    end

    def insert_into_file(file, txt, marker_txt)
      line = marker_txt

      file = file_path(file)

      if !File.exist?(file)
        create_initial_file(file)
      end  
      
      gsub_file file, /(#{Regexp.escape(line)})/mi do |match|
        "#{txt}\n#{match}"
      end
    end

    # helper for deciding file "write mode"
    def is_old_file?(file)
      File.new(file).mtime < (Time.now - time_limit)
    end

    def file_path(file)
      def_path = default_path || self.class.default_path || 'logs/tracing'
      file = File.join(def_path, file) 
    end

protected
    def gsub_file(path, regexp, *args, &block)
      content = File.read(path).gsub(regexp, *args, &block)
      File.open(path, 'wb') { |file| file.write(content) }
    end

    # default file "write mode"
    def mode(file)
      if !options[:overwrite] && File.exist?(file) && !is_old_file?(file)
        "a+"
      else
        "w+"
      end
    end
    
  end # class
    
end # tracing  
module Tracing
  class FileTarget
    include Tracing::DefaultPath

    attr_accessor :to_file    
    
    class << self
      include Tracing::DefaultPath
    end    

    def initialize(options)
      def_path = options[:default_path]
      _to_file = options[:to_file]

      @default_path = def_path if def_path
      @to_file = _to_file if _to_file
    end

    def append(txt, context)
      file = get_file(context)
      write_file(file, txt)
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
      def_path = default_path || self.class.default_path
      file = File.join(def_path, file) if self.class.default_path      
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
  end
end
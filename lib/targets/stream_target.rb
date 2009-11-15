module Tracing
  class StreamTarget
    attr_accessor :stream
    
    def append(txt, context)
      @stream << txt
    end
  end
end
module Tracing
  class StringTarget
    attr_accessor :text
    
    def append(txt, context)
      @text << txt
    end
  end
end
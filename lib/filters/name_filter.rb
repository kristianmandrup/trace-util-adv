module Tracing
  class NameFilter
    attr_accessor :options
    
    def initialize(options)
      @options = options
    end

    def allow?(name)
      true
    end        
  end
end
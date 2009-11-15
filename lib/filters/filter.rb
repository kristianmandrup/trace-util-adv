module Tracing

  # interface (abstract class)
  # instances of this form can be used as filters inside include/exclude lists
  class NameFilter 
    # return boolean
    def allow?(name)
      true
    end
  end


  # abstract filter  
  class BaseFilter
    attr_reader :name
    attr_accessor :rules

    class << self
      attr_accessor :filters
    
      # register symbol => filter mappings
      def register_filters(hash)
        @filters ||= {}
        filters.merge!(hash)
      end

      # array of symbols
      # [:special_filter, :stream_filter]
      def unregister_filters(hash)
        @filters ||= {}
        filters.reject!{|key, value| hash.include? key}
      end    
    end
  
    def initialize(options = {})
      @name = options[:name] || "Unknown filter"      
    end
    
    def name_allow_action(name)
      res = rules.rules_allow_action(name)
    end
  end  
end
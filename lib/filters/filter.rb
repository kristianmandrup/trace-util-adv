module Tracing
  # abstract filter  
  class BaseFilter
    attr_reader :name
    attr_accessor :rules

    class << self
      attr_accessor :filters
        
      # register symbol => filter mappings
      def register_filters(hash)
        # puts "register_filters: #{hash.inspect}"
        @filters ||= {}        
        @filters.merge!(hash)
        return @filters
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
      # puts "name_allow_action: #{name}"
      rules.rules_allow_action(name)
    end
  end  
end

Tracing::BaseFilter.register_filters({})


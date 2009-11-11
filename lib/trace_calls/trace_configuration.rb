module Tracing
  class Configuration
    include Tracing::Filter::Registration
    include Tracing::ActionHandler::Registration

    attr_accessor :final_yield_action

    def initialize(options)      
      register_filters(options.filters)
      register_action_handlers(options.action_handlers)
      @final_yield_action = options.final_yield_action
    end
    
  end
end     


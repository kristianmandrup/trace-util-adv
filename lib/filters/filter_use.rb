# include this on any class that should have filter functionality available
# for tracing, this is used on TraceExt, ActionHandler, Appender
module Tracing
  module FilterUse
    include Tracing::Filter::Registration    
    include Tracing::Filter::ExecUse
  
    attr_accessor :filters     
  end
end

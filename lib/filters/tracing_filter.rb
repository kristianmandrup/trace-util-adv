require 'filters/filter_exec'
require 'filters/filter_registration'

module Tracing::FilterUse
  include Tracing::Filter::Registration    
  include Tracing::Filter::ExecUse
  
  attr_accessor :filters     
end

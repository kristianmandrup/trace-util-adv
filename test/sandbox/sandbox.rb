require 'extensions/core_extensions'
require 'extensions/array_extensions'

class Parser
  attr_accessor :filters
  
  def parse(*args)
    @filters = args.flatten
  end
  
  def initialize(*args)
    @filters ||= []
    @filters.add(args)
  end
end


parser = Parser.new('a')
puts parser.filters.inspect

parser.parse [:x, :y, [:w]]
p parser.filters

puts [].blank?
puts nil.blank?
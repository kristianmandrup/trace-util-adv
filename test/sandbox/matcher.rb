def match?(name)
  rule = /Dryml/
  !(name =~ rule).nil?
end
# name = 'Drysml'
name = 'Blap'
puts "match: #{match?(name)}"
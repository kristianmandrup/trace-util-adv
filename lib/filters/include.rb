require 'filters/filter'
rfolders = Require.rfolder('filters', {:folders => ['simple', 'composite', 'list', 'msg_context', 'executor'], :root_files => :after, :exclude => 'include'})

puts rfolders.inspect


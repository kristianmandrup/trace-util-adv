require 'ftools'


@begin = "<?xml version='1.0' encoding='UTF-8'?>\n<tracing>\n"
@end = "</tracing>"

File.open('text.xml', "w") do |file|
  file.puts @begin
  file.puts @end
end
# 
# File.open('text.xml', "a+") do |file|
#   file.seek(-@end.length, IO:SEEK_END)
#   file.puts "hello world"
# end


# # # Create a new file and write to it  
# File.open('test.rb', 'w+') do |f2|  
#   # use "\n" for two lines of text  
#   f2.puts "Created by Satish\nThank God!"  
# end
# 
# f = File.new("test.rb", "a+")  
# #   
# # # SEEK_CUR - Seeks to first integer number parameter plus current position  
# # # SEEK_END - Seeks to first integer number parameter plus end of stream  
# # #   (you probably want a negative value for first integer number parameter)  
# # # SEEK_SET - Seeks to the absolute location given by first integer number parameter  
# # # :: is the scope operator - more on this later  
# # f.seek(12, IO::SEEK_SET)  
# # print f.readline  
# str = "hello world</end>"
# f.seek(-6, IO::SEEK_END)
# f.puts str
# f.close

def gsub_file(path, regexp, *args, &block)
  content = File.read(path).gsub(regexp, *args, &block)
  File.open(path, 'wb') { |file| file.write(content) }
end

line = '</tracing>'
gsub_file 'text.xml', /(#{Regexp.escape(line)})/mi do |match|
  "<line>hello</line>\n#{match}"
end

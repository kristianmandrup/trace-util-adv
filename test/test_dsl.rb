# AS IT SHOULD BE

class FileTarget < Target
  def write(file, context)
    ...
  end
end

class MyCustomTarget < FileTarget

 # build custom filepath depending on value of template_path
 def write_file(context)
    tpath = context.instance_var(:template_path)
    if tpath.match(/rapid/)
      dir = 'rapid'
    ...
    end
    file = File.join(dir, name)
    write(file, context) 
 end

end

---

Tracer.configation do |config|
  # register a custom target which stores files depending on value of instance variable @template_path
  config.targets do |targets|
    targets << MyCustomTarget.new :my_target
  end
  
  config.filters do |filters|
    filters << :i_classes => :DrymlBuilder
    filters << :i_methods => /exec_/
    filters << :i_class => {:class => :Template, :methods => [:build, :process_src]} 
  end
  
  config.appenders |appenders|
    # add an xml appender which appends to my_core_trace.xml whenever the instance variable @template_path =~ /core/ (working on a 'core' taglib)
    appenders << xml_appender :name => 'core-xml', :file => 'my_core_trace.xml' do |appender|
      appender.filters do |filters|
        filters << :i_vars => {:var => :template_path, :match => /core_/ }
      end
    end  
    
    # add html appender for rapid taglibs
    appenders << :html :name => 'html-rapid' do |appender|
      appender.filters do |filters|
        # only apply this appender when @template_path points at a rapid taglib 
        filters << :i_vars => {:var => :template_path, :match => /rapid_/ }    
        # use the custom target registered previously (previous registration not required)    
        targets << Tracer.target[:my_target]
        end
      end
      
    end
    
    # add logger appender that outputs to stdout whenever working on application.xml taglib
    appenders << :logger :name => 'logger-app', :target => :std_out do |appender|
      appender.filters do |filters|
        filters << :i_vars => {:var => :template_path, :match => /application\.xml/ }
      end
    end
  end  
end
  
Tracer.trace_modules 'Hobo::DRYML' do |mod|
  mod.trace :Template, :TemplateHandler, :DrymlBuilder
end

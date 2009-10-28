module Tracing

  # abstract filter  
  class BaseFilter
    attr_reader :name
    attr_accessor :rules

    class << self
      attr_accessor :filters

      # register symbol => filter mappings
      def register_filters(hash)
        filters.merge!(hash)
      end

      # array of symbols
      # [:special_filter, :stream_filter]
      def unregister_filters(hash)
        filters.reject!{|key, value| hash.include? key}
      end

      def filter_rule_mappings
        {
          :module_rules => :module_filter,
          :class_rules => :class_filter,
          :method_rules => :method_filter,        
          :var_rules => :vars_filter,        
          :modules => :composite_module_filter,
          :classes => :composite_class_filter,
          :vars => :composite_vars_filter
        }
      end

      def convenience_map
        {
         :module => :module_filter,
         :class => :class_filter,
         :method => :method_filter,
         :vars => :vars_filter,
        }
      end


      def default_filters
        {
         :module_filter => Tracing::ModuleFilter,
         :class_filter  => Tracing::ClassFilter,
         :method_filter => Tracing::MethodFilter,
         :vars_filter => Tracing::InstanceVarFilter,
         :composite_module_filter => Tracing::CompositeModuleFilter,
         :composite_class_filter => Tracing::CompositeClassFilter,
         :composite_vars_filter => Tracing::CompositeInstanceVarFilter
        }
      end

      def get_filter(options)
        convenience_map.select do |key, _filter|
          return _filter if options.has_key?(key) || options.has_key?(_filter)
        end
        filter_rule_mappings.select do |key, _filter|
          return _filter if options.has_key? key
        end
        return options        
      end

      # Example:
      # {:method, :include => 'hello,way'}
      # {:class, :include => 'A,B', :exclude => 'C'}
      def filter_by_hash(options)
        filters ||= default_filters

        # try by factory
        new_filter = Tracing::Filter.create_filter(options) 
        
        # puts "New filter: #{new_filter.inspect}"
        
        options = new_filter if new_filter
        
        # try by other means
        type = get_filter(options)      

        if type && type.kind_of?(Symbol)
          filter_class = filters[type]

          # puts "filter class: #{filter_class}"
        
          # ensure options has rules                  
          if filter_class
            filter_class.new(options)
          else
            raise Exception, "Filterclass not found"
          end
        end
      end

      # TODO: Refactor using symbol map!
      def create_filter(options)
        if options.kind_of? Hash
          _filter = filter_by_hash(options)
        elsif options.kind_of? BaseFilter
          options
        else
          nil
        end
      end
    
    end
  
    def initialize(options)
      @name = options[:name] || "Unknown filter"      
    end
    
    def name_allow_action(name)
      res = rules.rules_allow_action(name)
    end
  end

  # filter on module
  class ModuleFilter < BaseFilter
    def initialize(options)
      super(options)
      @rules = options[:module_rules] || {}
    end

    def allow_action(msg, context)
      name = context[:full_module_name]
      allow = name_allow_action(name)
    end
  end

  # filter on class name
  class ClassFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options[:class_rules] || {}
    end

    def allow_action(msg, context)
      name = context[:class_name]
      allow = name_allow_action(name)
    end
  end


  # filter on method
  class MethodFilter < BaseFilter
    def initialize(options)
      super(options)      
      @rules = options[:method_rules] || options[:method_filter] || {}
    end

    def allow_action(msg, context)
      name = context[:method_name]
      @encountered ||= []
      name_allow_action(name)
    end
  end
  
  # filter on instance variables
  class InstanceVarFilter < BaseFilter
    attr_accessor :var_name
        
    def initialize(options)
      super(options)      
      @rules = options[:var_rules] || {}
      var_name = options[:var_name]
    end

    def allow_action(msg, context)
      obj = context[:self]
      if var_name.kind_of?(Symbol) || var_name.kind_of?(String)
        value = obj.instance_variable_get(var_name)      
        return name_allow_action(value)
      end
      :yield
    end    
  end  
end
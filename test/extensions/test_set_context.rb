require "include"

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end


class TestHashExtensions < Test::Unit::TestCase

  def setup
  end

  def teardown
    ## Nothing really
  end

  def test_set_context
    context = {:class_name => "Hobo::Dryml", :method_name => "build_a"}.context
    expected = {
      :class_name       =>"Dryml", 
      :method_name      =>"build_a", 
      :modules          =>["Hobo"], 
      :full_class_name  =>"Hobo::Dryml",
      :full_modules_name=>"Hobo",
      :full_method_name =>"Hobo::Dryml.build_a"      
    }

    assert_equal expected, context, "resulting @context not as expected"    
  end

  def test_set_context_modules
    context = {:modules => ["Hobo"], :class_name => "Dryml", :method_name => "build_a"}.context
    puts "context set:" + context.inspect
    expected = {
      :method_name      =>"build_a",
      :class_name       => "Dryml",
      :modules          =>["Hobo"], 
      :full_class_name  =>"Hobo::Dryml",
      :full_modules_name=>"Hobo",
      :full_method_name =>"Hobo::Dryml.build_a"       
    }

    assert_equal expected, context, "resulting @context not as expected"    
  end

  def test_set_context_instance_vars
    context = {:vars => [{:a => 12, :b => "B"}]}.context
    puts "context set:" + context.inspect
    expected = {
      :vars => [{:a => 12, :b => "B"}]              
    }
  
    assert_equal expected, context, "resulting @context not as expected"    
  end
  
  def test_set_context_args
    context = {:args => [{:a => 12, :b => "B"}]}.context
    puts "context set:" + context.inspect
    expected = {
      :args => [{:a => 12, :b => "B"}]              
    }
  
    assert_equal expected, context, "resulting @context not as expected"    
  end
  
  def test_set_context_block
    context = {:block => true}.context
    puts "context set:" + context.inspect
    expected = {
      :block => true              
    }
  
    assert_equal expected, context, "resulting @context not as expected"    
  end
  
  def test_set_context_self
    obj = Person.new "Kristian"
    context = {:block => true, :self => obj}.context
    puts "context set:" + context.inspect
    expected = {
      :block => true,
      :self => obj              
    }
  
    assert_equal expected, context, "resulting @context not as expected"    
    assert_equal "Kristian", context[:self].name, "Kristian expected as person name"    
  end
end
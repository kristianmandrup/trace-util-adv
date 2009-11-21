require "include"


class TestCreateTemplates < Test::Unit::TestCase

  def test_tracer
    rule = {:template => :html}
    result = rule.template
    assert_equal result.class, Tracing::HtmlTemplate, "Should result in HtmlTemplate"    

    rule = {:template => :xml}
    result = rule.template
    assert_equal result.class, Tracing::XmlTemplate, "Should result in XmlTemplate"    

    rule = {:template => :string}
    result = rule.template
    assert_equal result.class, Tracing::StringTemplate, "Should result in StringTemplate"    
  end

end




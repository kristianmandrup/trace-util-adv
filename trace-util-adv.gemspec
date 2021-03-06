# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{trace-util-adv}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2009-11-22}
  s.description = %q{
      Configure tracing using context sensitive filters, appenders, output templates in a completely non-intrusive fashion. 
      Tracing can even be applied runtime as a response when certain conditions occur}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "Advanced TraceUtils tutorial.pdf",
     "CHANGELOG",
     "DOCUMENTATION",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "TODO.txt",
     "VERSION",
     "lib/action_handler/action_handler.rb",
     "lib/action_handler/action_handler_registration.rb",
     "lib/appenders/appender.rb",
     "lib/appenders/appender_mappings.rb",
     "lib/appenders/appender_registration.rb",
     "lib/appenders/base_appender.rb",
     "lib/appenders/file_appender.rb",
     "lib/appenders/include.rb",
     "lib/appenders/types/README-NOTE.txt",
     "lib/appenders/types/html_appender.rb",
     "lib/appenders/types/logger_appender.rb",
     "lib/appenders/types/stream_appender.rb",
     "lib/appenders/types/template_log_appender.rb",
     "lib/appenders/types/xml_appender.rb",
     "lib/extensions/array_extensions.rb",
     "lib/extensions/hash_extensions.rb",
     "lib/extensions/hash_rule_extensions.rb",
     "lib/extensions/include.rb",
     "lib/extensions/nilclass_extensions.rb",
     "lib/extensions/object_extensions.rb",
     "lib/extensions/string_extensions.rb",
     "lib/extensions/symbol_extensions.rb",
     "lib/filters/composite/composite_class_filter.rb",
     "lib/filters/composite/composite_module_filter.rb",
     "lib/filters/executor/filter_exec.rb",
     "lib/filters/filter.rb",
     "lib/filters/filter_factory.rb",
     "lib/filters/filter_mappings.rb",
     "lib/filters/filter_registration.rb",
     "lib/filters/filter_use.rb",
     "lib/filters/include.rb",
     "lib/filters/list/README-NOTE.txt",
     "lib/filters/list/list_instance_var_filter.rb",
     "lib/filters/msg_context/message_context_filters.rb",
     "lib/filters/name_filter.rb",
     "lib/filters/simple/argument_filter.rb",
     "lib/filters/simple/class_filter.rb",
     "lib/filters/simple/instance_var_filter.rb",
     "lib/filters/simple/method_filter.rb",
     "lib/filters/simple/module_filter.rb",
     "lib/output_handler/output_handler.rb",
     "lib/resources/jquery-1.3.2.min.js",
     "lib/resources/prototype.js",
     "lib/resources/tracing.css",
     "lib/resources/tracing.js",
     "lib/rules/rule_mappings.rb",
     "lib/rules/rule_match.rb",
     "lib/targets/README-NOTE.txt",
     "lib/targets/file_target.rb",
     "lib/targets/stream_target.rb",
     "lib/targets/string_target.rb",
     "lib/templates/base_template.rb",
     "lib/templates/html_template.rb",
     "lib/templates/include.rb",
     "lib/templates/string_template.rb",
     "lib/templates/template_mappings.rb",
     "lib/templates/xml_template.rb",
     "lib/trace-util-adv.rb",
     "lib/trace_calls/trace_calls.rb",
     "lib/trace_calls/trace_configuration.rb",
     "lib/trace_calls/trace_ext.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/trace-util-adv_spec.rb",
     "trace-util-adv.gemspec"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/trace-util-adv}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{adds advancing tracing capability to your ruby code}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/trace-util-adv_spec.rb",
     "test/action_handler/include.rb",
     "test/action_handler/test_action_handler.rb",
     "test/action_handler/test_create_action_handler.rb",
     "test/appenders/include.rb",
     "test/appenders/test_appender_filters.rb",
     "test/appenders/test_appender_templates.rb",
     "test/appenders/test_create_appender.rb",
     "test/appenders/test_html_appender.rb",
     "test/appenders/test_stream_appender.rb",
     "test/appenders/test_template_log_appender.rb",
     "test/appenders/test_xml_appender.rb",
     "test/extensions/include.rb",
     "test/extensions/test_filters_creation.rb",
     "test/extensions/test_hash_extensions.rb",
     "test/extensions/test_hash_filter_extensions.rb",
     "test/extensions/test_set_context.rb",
     "test/extensions/test_string_extensions.rb",
     "test/extensions/test_symbol_extensions.rb",
     "test/filters/chain/test_filters_chain.rb",
     "test/filters/composite/test_composite_class_filter.rb",
     "test/filters/composite/test_composite_module_filter.rb",
     "test/filters/composite/test_composite_var_filter.rb",
     "test/filters/executor/test_filter_exec.rb",
     "test/filters/include.rb",
     "test/filters/msg_context/test_custom_filters.rb",
     "test/filters/simple/test_base_filter.rb",
     "test/filters/simple/test_class_filter.rb",
     "test/filters/simple/test_instancevar_filter.rb",
     "test/filters/simple/test_method_filter.rb",
     "test/filters/simple/test_module_filter.rb",
     "test/listeners/test_listeners.rb",
     "test/samples/include.rb",
     "test/samples/sample_classes.rb",
     "test/samples/sample_composite_filters.rb",
     "test/samples/sample_filters.rb",
     "test/sandbox/matcher.rb",
     "test/sandbox/sandbox.rb",
     "test/sandbox/test_xml_gen.rb",
     "test/targets/test_create_targets.rb",
     "test/templates/include.rb",
     "test/templates/test_create_templates.rb",
     "test/templates/test_exec_templates.rb",
     "test/trace_calls/include.rb",
     "test/trace_calls/test_configure_.rb",
     "test/trace_calls/tracing/test_html_tracing.rb",
     "test/trace_calls/tracing/test_logger_tracing.rb",
     "test/trace_calls/tracing/test_stream_tracing.rb",
     "test/trace_calls/tracing/test_teamplate_log_tracing.rb",
     "test/trace_calls/tracing/test_xml_tracing.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<require-magic>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<require-magic>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<require-magic>, [">= 0"])
  end
end


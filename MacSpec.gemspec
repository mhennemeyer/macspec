# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{MacSpec}
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthias Hennemeyer"]
  s.date = %q{2010-03-03}
  s.description = %q{MacSpec is a feature minimal RSpec clone that is specifically built to work with MacRuby.}
  s.email = %q{mhennemeyer@me.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "MacSpec.gemspec",
     "README.rdoc",
     "Rakefile",
     "lib/mac_spec/matcher_system.rb",
     "lib/mac_spec/matcher_system/built_in/change_expectations.rb",
     "lib/mac_spec/matcher_system/built_in/enumerable_expectations.rb",
     "lib/mac_spec/matcher_system/built_in/error_expectations.rb",
     "lib/mac_spec/matcher_system/built_in/operator_expectations.rb",
     "lib/mac_spec/matcher_system/built_in/truth_expectations.rb",
     "lib/mac_spec/matcher_system/core/def_matcher.rb",
     "lib/mac_spec/matcher_system/core/exceptions.rb",
     "lib/mac_spec/matcher_system/core/expectation_builder.rb",
     "lib/mac_spec/matcher_system/core/matcher_builder.rb",
     "lib/mac_spec/matcher_system/core/modals.rb",
     "lib/mac_spec/mocking_framework.rb",
     "lib/mac_spec/mocking_framework/extensions/kernel_extension.rb",
     "lib/mac_spec/mocking_framework/extensions/object_extension.rb",
     "lib/mac_spec/mocking_framework/message_expectation.rb",
     "lib/mac_spec/mocking_framework/mock.rb",
     "lib/mac_spec/testing_framework.rb",
     "lib/mac_spec/testing_framework/core/functions.rb",
     "lib/mac_spec/testing_framework/core/kernel_extension.rb",
     "lib/mac_spec/testing_framework/core/test_case_class_methods.rb",
     "lib/mac_spec/version.rb",
     "lib/macspec.rb",
     "test/all.rb",
     "test/mac_spec/matcher_system/built_in/change_expectations_test.rb",
     "test/mac_spec/matcher_system/built_in/enumerable_expectations_test.rb",
     "test/mac_spec/matcher_system/built_in/error_expectations_test.rb",
     "test/mac_spec/matcher_system/built_in/operator_expectations_test.rb",
     "test/mac_spec/matcher_system/built_in/truth_expectations_test.rb",
     "test/mac_spec/matcher_system/core/def_matcher_test.rb",
     "test/mac_spec/matcher_system/core/expectation_builder_test.rb",
     "test/mac_spec/matcher_system/core/matcher_builder_test.rb",
     "test/mac_spec/matcher_system/core/modals_test.rb",
     "test/mac_spec/matcher_system/script.rb",
     "test/mac_spec/matcher_system/test_helper.rb",
     "test/mac_spec/mocking_framework/extensions/kernel_extension_test.rb",
     "test/mac_spec/mocking_framework/extensions/object_extension_test.rb",
     "test/mac_spec/mocking_framework/message_expectation_test.rb",
     "test/mac_spec/mocking_framework/mock_test.rb",
     "test/mac_spec/mocking_framework/regression/mocking_class_methods_test.rb",
     "test/mac_spec/mocking_framework/regression/negative_expectation_test.rb",
     "test/mac_spec/mocking_framework/regression/stub_test.rb",
     "test/mac_spec/mocking_framework/test_helper.rb",
     "test/mac_spec/test_helper.rb",
     "test/mac_spec/testing_framework/performance/x_test_performance.rb",
     "test/mac_spec/testing_framework/regression/before_test.rb",
     "test/mac_spec/testing_framework/regression/deep_nested_example_groups_test.rb",
     "test/mac_spec/testing_framework/regression/description_string_test.rb",
     "test/mac_spec/testing_framework/regression/example_name_test.rb",
     "test/mac_spec/testing_framework/regression/inherit_not_double_test.rb",
     "test/mac_spec/testing_framework/regression/surrounding_module_scope_test.rb",
     "test/mac_spec/testing_framework/regression/testing_functions_test.rb",
     "test/mac_spec/testing_framework/test_helper.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/mhennemeyer/MacSpec}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{MacSpec is a feature minimal RSpec clone that is specifically built to work with MacRuby.}
  s.test_files = [
    "test/all.rb",
     "test/mac_spec/matcher_system/built_in/change_expectations_test.rb",
     "test/mac_spec/matcher_system/built_in/enumerable_expectations_test.rb",
     "test/mac_spec/matcher_system/built_in/error_expectations_test.rb",
     "test/mac_spec/matcher_system/built_in/operator_expectations_test.rb",
     "test/mac_spec/matcher_system/built_in/truth_expectations_test.rb",
     "test/mac_spec/matcher_system/core/def_matcher_test.rb",
     "test/mac_spec/matcher_system/core/expectation_builder_test.rb",
     "test/mac_spec/matcher_system/core/matcher_builder_test.rb",
     "test/mac_spec/matcher_system/core/modals_test.rb",
     "test/mac_spec/matcher_system/script.rb",
     "test/mac_spec/matcher_system/test_helper.rb",
     "test/mac_spec/mocking_framework/extensions/kernel_extension_test.rb",
     "test/mac_spec/mocking_framework/extensions/object_extension_test.rb",
     "test/mac_spec/mocking_framework/message_expectation_test.rb",
     "test/mac_spec/mocking_framework/mock_test.rb",
     "test/mac_spec/mocking_framework/regression/mocking_class_methods_test.rb",
     "test/mac_spec/mocking_framework/regression/negative_expectation_test.rb",
     "test/mac_spec/mocking_framework/regression/stub_test.rb",
     "test/mac_spec/mocking_framework/test_helper.rb",
     "test/mac_spec/test_helper.rb",
     "test/mac_spec/testing_framework/performance/x_test_performance.rb",
     "test/mac_spec/testing_framework/regression/before_test.rb",
     "test/mac_spec/testing_framework/regression/deep_nested_example_groups_test.rb",
     "test/mac_spec/testing_framework/regression/description_string_test.rb",
     "test/mac_spec/testing_framework/regression/example_name_test.rb",
     "test/mac_spec/testing_framework/regression/inherit_not_double_test.rb",
     "test/mac_spec/testing_framework/regression/surrounding_module_scope_test.rb",
     "test/mac_spec/testing_framework/regression/testing_functions_test.rb",
     "test/mac_spec/testing_framework/test_helper.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end


# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{se_gem}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Steadman"]
  s.date = %q{2009-07-12}
  s.email = %q{ss@stdmn.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "lib/core_ext.rb",
     "lib/debug.rb",
     "lib/se/aspect.rb",
     "lib/se/core_ext/array.rb",
     "lib/se/core_ext/benchmark.rb",
     "lib/se/core_ext/date.rb",
     "lib/se/core_ext/dir.rb",
     "lib/se/core_ext/object.rb",
     "lib/se/core_ext/regexp.rb",
     "lib/se/core_ext/retryable.rb",
     "lib/se/core_ext/socket.rb",
     "lib/se/core_ext/yaml.rb",
     "lib/se/debug.rb",
     "lib/se/memory_profiler.rb",
     "lib/se/metaclass.rb",
     "lib/se/negator.rb",
     "lib/se/pager.rb",
     "lib/se/sleeper.rb",
     "lib/se/test/difference.rb",
     "lib/se/timer.rb",
     "lib/se/unicode.rb",
     "lib/se_gem.rb",
     "lib/test.rb"
  ]
  s.homepage = %q{http://github.com/ss/se_gem}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A collection of handy scripts.}
  s.test_files = [
    "test/se/sleeper_test.rb",
     "test/se/aspect_test.rb",
     "test/se/negator_test.rb",
     "test/se/unicode_test.rb",
     "test/se/core_ext/dir_test.rb",
     "test/se/core_ext/retryable_test.rb",
     "test/se/core_ext/object_test.rb",
     "test/se/core_ext/date_test.rb",
     "test/se/core_ext/array_test.rb",
     "test/se/core_ext/regexp_test.rb",
     "test/se/timer_test.rb",
     "test/se/memory_profiler_test.rb",
     "test/se/debug_test.rb"
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

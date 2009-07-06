# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{se_gem}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Steadman"]
  s.date = %q{2009-07-05}
  s.email = %q{ss@stdmn.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "lib/core_ext.rb",
     "lib/debug.rb",
     "lib/se/core_ext/array.rb",
     "lib/se/core_ext/dir.rb",
     "lib/se/core_ext/meta_class.rb",
     "lib/se/core_ext/object.rb",
     "lib/se/debug/debug.rb",
     "lib/se_gem.rb",
     "se_gem.gemspec",
     "test/se/core_ext/array_test.rb",
     "test/se/core_ext/dir_test.rb",
     "test/se/core_ext/object_test.rb",
     "test/se/debug/debug_test.rb"
  ]
  s.homepage = %q{http://github.com/ss/se_gem}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A collection of handy scripts.}
  s.test_files = [
    "test/se/debug/debug_test.rb",
     "test/se/core_ext/dir_test.rb",
     "test/se/core_ext/object_test.rb",
     "test/se/core_ext/array_test.rb"
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

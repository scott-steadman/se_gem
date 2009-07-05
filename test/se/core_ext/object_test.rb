require 'test/unit'
require "#{File.dirname(__FILE__)}/../../../lib/se/core_ext/object"

class ObjectTest < Test::Unit::TestCase

  def test_try_with_null
    assert_nil nil.try(:name)
  end

  def test_try_with_missing_method
    assert_nil "foo".try(:name)
    assert_nil "foo".try(:name, 1)
  end

  def test_try_with_valid_method
    assert_equal "Class", Class.try(:name)
    assert_equal 'C', "Class".try(:[], (0..0))
  end

  def test_tap
    assert_equal 'foo', 'foo'.tap {|ii| ii + '_bar'}
    assert_equal 'foo_bar', 'foo'.tap {|ii| ii << '_bar'}
  end

end

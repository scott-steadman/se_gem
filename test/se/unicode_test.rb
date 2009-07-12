require 'test/unit'
require "#{File.dirname(__FILE__)}/../../lib/se/unicode"

class UnicodeTest < Test::Unit::TestCase

  def test_unicode
    assert_equal "a", "#{SE::Unicode::U0061}"
  end

  def test_excepton_raised_on_invalid_unicode_value
    assert_raise NameError do
      "#{SE::Unicode::U65}"
    end
  end

end

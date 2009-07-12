require 'test/unit'
require "#{File.dirname(__FILE__)}/../../../lib/se/core_ext/regexp"

class RegexpTest < Test::Unit::TestCase

  def test_blank
    assert_equal false, /abc/.blank?, 'blank? should always return false'
  end

  def test_include
    assert_equal true, /a|b|c/.include?('a'), '/a|b|c/ should match a'
    assert_equal false, /a|b|c/.include?('x'), '/a|b|c/ should not match a'
  end

end

require 'test/unit'
require "#{File.dirname(__FILE__)}/../../lib/se/negator"

class NegatorTest < Test::Unit::TestCase

  def test_negation
    assert_equal false, [].not.empty?
    assert_equal true, ['1'].not.empty?
  end

end



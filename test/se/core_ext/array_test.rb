require 'test/unit'
require "#{File.dirname(__FILE__)}/../../../lib/se/core_ext/array"

class ArrayTest < Test::Unit::TestCase

  def test_each_except_with_scalar
    array = [1, 2, 3, 4]
    result = []
    array.each_except(3) {|ii| result << ii}
    assert_equal [1,2,4], result
  end

  def test_each_except_with_scalars
    array = [1, 2, 3, 4]
    result = []
    array.each_except(3,4) {|ii| result << ii}
    assert_equal [1,2], result
  end

  def test_each_except_with_array
    array = [1, 2, 3, 4]
    result = []
    array.each_except([3,4]) {|ii| result << ii}
    assert_equal [1,2], result
  end

end

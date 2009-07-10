require 'test/unit'
require "#{File.dirname(__FILE__)}/../../../lib/se/core_ext/date"

class DateTest < Test::Unit::TestCase

  def test_days_in_year_for_normal_year
    assert_equal 365, Date.parse('2009-01-01').days_in_year
  end

  def test_days_in_year_for_leap_year
    assert_equal 366, Date.parse('2000-01-01').days_in_year
  end


end

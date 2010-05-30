require 'test/unit'
require "#{File.dirname(__FILE__)}/../../lib/se/debug"

class DebugTest < Test::Unit::TestCase

  def test_class_hierarchy
    result = SE::Debug.class_hierarchy(RuntimeError)
    puts result
    assert_match "RuntimeError\n includes:\n  Kernel\n", result
    assert_match "extends:\n  Kernel\n", result
    assert_match "superclass: StandardError\n", result
  end

end



require 'test/unit'
require "#{File.dirname(__FILE__)}/../../../lib/se/core_ext/retryable"

class RetryableTest < Test::Unit::TestCase

  def test_retryable_smoke_test
    flag = true
    Kernel.retryable(:tries => 2) do
      if flag
        flag = false
        raise 'oops!'
      end
    end
  end

end

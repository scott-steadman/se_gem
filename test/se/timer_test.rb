require 'test/unit'
require "#{File.dirname(__FILE__)}/../../lib/se/timer"

class TimerTest < Test::Unit::TestCase

  def test_thread_safety
    threads = []
    3.times do
      threads << Thread.new do
        SE::Timer.enabled = true
        SE::Timer.start(:thread)
        sleep(1)
        SE::Timer.end(:thread)
        assert_equal 1, SE::Timer.stats[:thread][:calls], 'Incorrect call count'
      end
    end
    threads.each {|ii| ii.join}
  end

  class Base
    def foo
      :foo
    end
  end

  class Foo < Base
  end

  def test_inherited_class_timing
    SE::Timer.time_method(Base, :foo, 'base.foo')
    SE::Timer.time_method(Foo,  :foo, 'foo.foo' )
    SE::Timer.enabled = true
    Foo.new.foo
    assert_equal ['base.foo','foo.foo'], SE::Timer.stats.keys.sort
  end

end # class TimerTest

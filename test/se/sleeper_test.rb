require 'test/unit'
require "#{File.dirname(__FILE__)}/../../lib/se/sleeper"

class SleeperTest < Test::Unit::TestCase

  def teardown
    Sleeper.send(:kill_all_sleepers)
  end

  def test_initialize_accepts_no_block
    @sleeper = Sleeper.new(1)
  end

  def test_block_executed_multiple_times
    wakes = 0
    @sleeper = Sleeper.new(1) {wakes += 1}
    sleep(3)
    assert_equal 2, wakes
  end

  def test_reset_invokes_after_reset_blocks
    resets = 0
    @sleeper = Sleeper.new(1)
    @sleeper.after_reset {resets += 1}
    @sleeper.reset
    assert_equal 1, resets, 'Invalid number of resets'
  end

  def test_reset_prevents_after_wake_execution
    @sleeper = Sleeper.new(2) {raise %q{after_wake shouldn't be called}}
    3.times do
      sleep(1)
      @sleeper.reset
    end
  end

  def test_terminate_invokes_after_terminate_blocks
    terminates = 0
    sleeper = Sleeper.new(5)
    sleeper.after_terminate {terminates += 1}
    sleeper.terminate
    assert_equal 1, terminates, 'Invalid number of terminates'
  end

  def test_signals_kills_sleeper_threads
    Sleeper::OLD_HANDLERS.keys.each do |sig|
      5.times {Sleeper.new(30)}
      Process.kill(sig, $$)
      assert_equal 1, Thread.list.size, 'too many threads left'
    end
  end

end

# Sleep, execute block, repeat.
# Allow resetting of the timer.
#
# An array of sleepers is stored in +Thread.main[:sleepers]+ to make
# sure we terminate all sleeper threads when a signal is trapped.
#
class Sleeper

  # a hash of signals and their old handlers
  OLD_HANDLERS = {
    'INT'   => nil,
    'TERM'  => nil,
  }

  class Reset < Exception ; end

  attr_reader :thread

  # Return an array of Sleepers in this process.
  def self.sleepers
    Thread.main[:sleepers] ||= begin
      set_traps
      []
    end
  end


  # Initialize the sleeper by passing a +timetout+ in seconds and an
  # optional block.
  #
  def initialize(timeout, &block)
    after_wake &block if block_given?

    Sleeper.sleepers << self

    @thread = Thread.new do
      while true do
        begin
          sleep(timeout.to_i)
          # TODO: investigate using Thread.critical
          Thread.current[:awake] = true
          @after_wake.each {|block| block.call} if @after_wake
        rescue Reset
          @after_reset.each {|block| block.call} if @after_reset
          # re-start sleep cycle
        ensure
          Thread.current[:awake] = false
        end
      end
    end

  end

  # Reset the sleeper.
  #
  # This will cause all +after_reset+ handlers to be executed.
  #
  def reset
    thread.raise(Reset.new) unless thread[:awake]
  end

  # Terminate the Sleeper.
  #
  # This will cause all +after_terminate+ handlers to be executed.
  #
  def terminate
    Sleeper.sleepers.delete(self)
    thread.terminate
    @after_terminate.each {|block| block.call} if @after_terminate
    @thread = nil
  end

  # Add a block to be executed after the Sleeper wakes up.
  def after_wake(&block)
    (@after_wake ||= []) << block
  end

  # Add a block to be executed after the Sleeper is reset.
  def after_reset(&block)
    (@after_reset ||= []) << block
  end

  # Add a block to be executed after the Sleeper is terminated.
  def after_terminate(&block)
    (@after_terminate ||= []) << block
  end

private

  def self.set_traps
    OLD_HANDLERS.keys.each do |sig|
      OLD_HANDLERS[sig] = Signal.trap(sig) do
        kill_all_sleepers
        OLD_HANDLERS[sig].call unless 'DEFAULT' == OLD_HANDLERS[sig]
      end
    end
  end

  def self.kill_all_sleepers
    while to_kill = Thread.main[:sleepers].pop do
      to_kill.terminate
    end
  end

end

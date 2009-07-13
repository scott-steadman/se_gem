require 'lib/se/aspect'

module SE
  class Timer

    class << self
      attr_accessor :stats, :timers, :enabled

      def start(item)
        return unless enabled
        timers[item] = Time.now
      end

      def end(item)
        return unless enabled
        return unless timers[item]
        self.stats[item][:calls] += 1
        self.stats[item][:time]  += Time.now - timers[item]
      end

      def time_block(item)
        self.start(item)
        retval = yield
        self.end(item)
        return retval
      end

      # Note: Does not work on methods that take blocks.
      def time_method(klass, method, item, type="instance")
        item ||= "#{klass}::#{method}"
        SE::Aspect.define do
          if type == "instance"
            with_instance_of(klass).before(method.to_sym) {SE::Timer.start(item)}
            with_instance_of(klass).after(method.to_sym) {SE::Timer.end(item)}
          else
            with_class(klass).before(method.to_sym) {SE::Timer.start(item)}
            with_class(klass).after(method.to_sym) {SE::Timer.end(item)}
          end
        end
      end

      def reset
        stats.clear
        timers.clear
        enabled = true
      end

      def stats
        Thread.current['SE::Timer.stats'] ||= Hash.new {|hash, key| hash[key] = Hash.new(0.0)}
      end

      def timers
        Thread.current['Worfkeed::Timer.timers'] ||= {}
      end

      def enabled
        Thread.current['SE::timer.enabled'] ||= false
      end

      def enabled=(value)
        Thread.current['SE::timer.enabled'] = value
      end

    end

  end # class Timer
end # module SE

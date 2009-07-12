# From http://scottstuff.net/blog/articles/2006/08/17/memory-leak-profiling-with-rails

# Simple memory profiler.
#
# Calling SE::MemoryProfiler.start will spin up a thread that writes
# instance counts to +log_file_name+ and optionally writes String
# values to +string_log_file_name+.
#
#  Example:
#
#   # write to log every 3 seconds
#   SE::MemoryProfiler.start(:every=>3)
#
module SE
  class MemoryProfiler
    DEFAULTS = {:every => 10, :string_debug => false}

    # Start the profiler.
    #
    # opts can be one of:
    #   +every+         => delay in seconds between output to +log_file_name+ (default 10)
    #   +string_debug+  => whether to write string values to +string_log_file_name+ (default false)
    #
    def self.start(opt={})
      opt = DEFAULTS.dup.merge(opt)

      Thread.new do
        prev = Hash.new(0)
        curr = Hash.new(0)
        curr_strings = []
        delta = Hash.new(0)

        file = File.open(log_file_name,'w')

        loop do
          begin
            GC.start
            curr.clear

            curr_strings = [] if opt[:string_debug]

            ObjectSpace.each_object do |o|
              curr[o.class] += 1 #Marshal.dump(o).size rescue 1
              if opt[:string_debug] and o.class == String
                curr_strings.push o
              end
            end

            if opt[:string_debug]
              File.open(string_log_file_name, 'w') do |f|
                curr_strings.sort.each do |s|
                  f.puts s
                end
              end
              curr_strings.clear
            end

            delta.clear
            (curr.keys + delta.keys).uniq.each do |k,v|
              delta[k] = curr[k]-prev[k]
            end

            file.puts "Top 20"
            delta.sort_by { |k,v| -v.abs }[0..19].sort_by { |k,v| -v}.each do |k,v|
              file.printf "%+5d: %s (%d)\n", v, k.name, curr[k] unless v == 0
            end
            file.flush

            delta.clear
            prev.clear
            prev.update curr
            GC.start
          rescue Exception => err
            STDERR.puts "** memory_profiler error: #{err}"
          end
          sleep opt[:every].to_i
        end
      end
    end


    # log file where object counts are written
    def self.log_file_name
      'memory_profiler.log'
    end

    # log file where string values are written
    def self.string_log_file_name(time=Time.now)
      "memory_profiler_strings.log.#{time.to_i}"
    end

  end # class MemoryProfile
end # module SE

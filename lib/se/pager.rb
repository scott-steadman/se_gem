# From: http://nex-3.com/posts/73-git-style-automatic-paging-in-ruby
#
# Route STDOUT and STDERR through +less+ if output is more than one screen
#
# Call +SE::Pager.run_pager+ before you emit output in your program.
#
module SE
  module Pager
    def self.run_pager(less_opts='FRSX')
      return if PLATFORM =~ /win32/
      return unless STDOUT.tty?

      read, write = IO.pipe

      if Kernel.fork.nil?
        # Child process
        STDOUT.reopen(write)
        STDERR.reopen(write) if STDERR.tty?
        read.close
        write.close
        return
      end

      # Parent process, become pager
      STDIN.reopen(read)
      read.close
      write.close

      # set less options via envar
      ENV['LESS'] = less_opts

      # Wait until we have input before we start the pager
      Kernel.select [STDIN]

      pager = ENV['PAGER'] || 'less'
      exec pager rescue exec "/bin/sh", "-c", pager
    end
  end # module Pager
end # module SE

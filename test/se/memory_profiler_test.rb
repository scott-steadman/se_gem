require 'test/unit'
require "#{File.dirname(__FILE__)}/../../lib/se/memory_profiler"
require 'fileutils'

class MemoryProfilerTest < Test::Unit::TestCase

  def teardown
    FileUtils.rm(SE::MemoryProfiler.log_file_name)
  end

  def test_memory_profiler
    SE::MemoryProfiler.start(:every=>1)
    sleep 3
    assert_equal true, File.exists?(SE::MemoryProfiler.log_file_name)
    lines = File.open(SE::MemoryProfiler.log_file_name, 'r') {|f| f.readlines}
    assert_equal 3, lines.grep(/Top 20/).size
  end

end

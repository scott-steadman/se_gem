require 'test/unit'
require "#{File.dirname(__FILE__)}/../../../lib/se/core_ext/dir"

class DirTest < Test::Unit::TestCase

  def test_dir_to_hash
    result = Dir.to_hash("#{File.dirname(__FILE__)}/..")
    assert result['core_ext'].has_key?('dir_test.rb')
  end

end



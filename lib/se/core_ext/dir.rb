#
# Dir class extensions.
#
module SE
  module CoreExtensions
    module Dir

      module InstanceMethods

      end # module InstanceMethods

      module ClassMethods

        # Return a directory as a hash.
        #
        # Example:
        #   Dir.to_hash('.')
        #     #=> {
        #       'core_ext' => {
        #         'object_test.rb'=>nil,
        #         'dir_test.rb'=>nil,
        #         'array_test.rb'=>nil,
        #       },
        #       'test'     => {
        #       },
        #       'debug'    => {
        #         'debug_test.rb'=>nil
        #       }
        #     }
        #
        # call-seq:
        #   Dir.to_hash('/tmp') => hash
        #
        def to_hash(dir)
          return nil unless File.exist?(dir)

          entries(dir).delete_if {|f| f =~ /^\.{1,2}$/}.inject({}) do |values, entry|
            full_entry = File.join(dir, entry)
            values.merge!(entry => File.directory?(full_entry) ? to_hash(full_entry) : nil)
          end
        end

      end # module ClassMethods

    end # module Dir
  end # module CoreExtensions
end # module SE

#Dir.send(:include, SE::CoreExtensions::Dir::InstanceMethods)
Dir.send(:extend, SE::CoreExtensions::Dir::ClassMethods)

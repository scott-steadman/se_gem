#
# Array class extensions.
#
module SE
  module CoreExtensions
    module Array

      module InstanceMethods

        # exclude values from an each call
        def each_except(*values)
          values = [values].flatten
          each do |ii|
            yield ii unless values.include?(ii)
          end
        end

      end # module InstanceMethods

      module ClassMethods

      end # module ClassMethods

    end # module Array
  end # module CoreExtensions
end # module SE

Array.send(:include, SE::CoreExtensions::Array::InstanceMethods)
#Array.send(:extend, SE::CoreExtensions::Array::ClassMethods)

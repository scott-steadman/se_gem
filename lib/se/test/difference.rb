# From: http://project.ioni.st/post/217#post-217

module SE
  module Test
    module Difference

      #
      # Example:
      #
      #   assert_difference Model, :count do
      #     Model.create
      #   end
      #
      def assert_difference(object, method, diff=1)
        before = object.send(method)
        yield
        assert_equal before + diff, object.send(method)
      end

      # Example:
      #
      #   assert_no_difference Model, :count do
      #     Model.new
      #   end
      #
      def assert_no_difference(object, method)
        before = object.send(method)
        yield
        assert_equal 0, object.send(method)
      end

    end # module Difference
  end # module Test
end # module SE

# vim :sw=2 ts=2 et nowrap ai bg=dark


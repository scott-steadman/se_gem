#
# Object class extensions.
#
module SE
  module CoreExtensions
    module Object

      module InstanceMethods

        #
        # Example:
        #   @person.name unless @person.nil?
        # vs
        #   @person.try(:name)
        #
        # call-seq:
        #   object.try(:id) => num
        #   object.try(:bad_method) => nil
        #
        def try(method, *args, &block)
          self.send(method, *args, &block) if respond_to?(method)
        end

        # Example:
        #   my_method("foo: #{foo}".tap{|ii| p ii})
        # vs
        #   p ii = "foo: #{foo}"
        #   my_method(ii)
        #
        # call-seq:
        #   object.tap {block} => object
        #
        def tap
          yield self
          self
        end

      end # module InstanceMethods

      module ClassMethods

      end # module ClassMethods

    end # module Object
  end # module CoreExtensions
end # module SE

Object.send(:include, SE::CoreExtensions::Object::InstanceMethods)
#Object.send(:extend, SE::CoreExtensions::Object::ClassMethods)

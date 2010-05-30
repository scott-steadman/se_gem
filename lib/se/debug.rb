require 'set' unless defined?(Set)

# This module contains various debugging methods
module SE
  module Debug

    # these modules include or extend themselves and cause problems
    # TODO: Detect it in-place and don't recurse
    RECURSIVE_MODULES = [
      defined?(ActiveSupport::CoreExtensions::Module) && ActiveSupport::CoreExtensions::Module,
      defined?(ActiveSupport::Dependencies::ClassConstMissing) && ActiveSupport::Dependencies::ClassConstMissing,
      defined?(ActiveSupport::Dependencies::Loadable) && ActiveSupport::Dependencies::Loadable,
      defined?(ActiveSupport::Dependencies::ModuleConstMissing) && ActiveSupport::Dependencies::ModuleConstMissing,
      defined?(ActiveSupport::Deprecation::ClassMethods) && ActiveSupport::Deprecation::ClassMethods,
      defined?(Base64) && Base64,
      defined?(Base64::Deprecated) && Base64::Deprecated,
      defined?(ERB::Util) && ERB::Util,
      defined?(JSON::Ext::Generator::GeneratorMethods::Object) && JSON::Ext::Generator::GeneratorMethods::Object,
      defined?(Kernel) && Kernel,
      defined?(MethodCache) && MethodCache,
      defined?(Mocha::ClassMethods) && Mocha::ClassMethods,
      defined?(Mocha::ModuleMethods) && Mocha::ModuleMethods,
      defined?(Mocha::ObjectMethods) && Mocha::ObjectMethods,
      defined?(PP::ObjectMixin) && PP::ObjectMixin,
    ].compact

    # Return class hierarchy as a String.
    #
    # examples:
    #  SE::Debug.class_hierarchy(RuntimeError)
    #  #=> RuntimeError
    #  #=>  includes:
    #  #=>   Kernel
    #  #=>  extends:
    #  #=>   Kernel
    #  #=>  superclass: StandardError
    #  #=>   includes:
    #  #=>    Kernel
    #  #=>   extends:
    #  #=>    Kernel
    #  #=>   superclass: Exception
    #  #=>    includes:
    #  #=>     Kernel
    #  #=>    extends:
    #  #=>     Kernel
    #
    # call-seq:
    #  Debug.class_hierarchy(object) => String
    #
    def self.class_hierarchy(klass, opts={})
      return nil if klass.nil?

      opts[:indent] ||= 0
      opts[:limit]  ||= 10
      return '<truncated>' if opts[:indent] > opts[:limit]

      return nil if opts[:omit_recursives] && RECURSIVE_MODULES.include?(klass)

      opts[:seen] ||= Set.new(RECURSIVE_MODULES)

      buf = [ klass ]

      unless opts[:seen].include?(klass)
        opts[:seen] << (klass = klass.is_a?(Class) ? klass : klass.class)

        indent = ' ' * (opts[:indent] + 1)


        #
        # Included Modules
        #
        includes = []
        klass.included_modules.each do |ii|
          next if ii == klass
          next unless child = class_hierarchy(ii, opts.merge(:indent => indent.size + 1))
          includes << indent + ' ' + child
        end

        if ! includes.empty?
          buf << indent + 'includes:'
          buf += includes
        end


        #
        # Extended Modules
        #
        includes.clear
        (class << klass; self; end).included_modules.each do |ii|
          next if ii == klass
          next unless child = class_hierarchy(ii, opts.merge(:indent => indent.size + 1))
          includes << indent + ' ' + child
        end

        if ! includes.empty?
          buf << indent + 'extends:'
          buf += includes
        end


        # superclass
        if Object != klass.superclass && (child = class_hierarchy(klass.superclass, opts.merge(:indent => indent.size)))
          buf << indent + 'superclass: ' + child
        end
      end


      buf.compact.join("\n")
    end

  end # module Debug
end # module SE

# vim: sw=2 ts=2 et ai nowrap bg=dark

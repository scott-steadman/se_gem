# This module contains various debugging methods
module SE
  module Debug

    # Return class hierarchy as a String.
    #
    # examples:
    #  SE::Debug.class_hierarchy(RuntimeError)
    #  #=> RuntimeError includes: []
    #  #=>  extends: StandardError includes: []
    #  #=>   extends: Exception includes: []
    #  #=>    extends: Object includes: [Kernel]
    #
    #
    # call-seq:
    #  Debug.class_hierarchy(object) => String
    #
    def self.class_hierarchy(value, buf='', indent=0)
      value = value.is_a?(Class) ? value : value.class
      klass = value

      buf << klass.name

      if klass.superclass
        buf << " includes: [#{(klass.ancestors[1..-1] - klass.superclass.ancestors).join(',')}]"
        buf << "\n" << (' '*(indent+1)) << 'extends: '
        class_hierarchy(klass.superclass, buf, indent + 1)
      else
        buf << " includes: [#{klass.ancestors[1..-1].join(',')}]"
      end

      buf
    end

  end # module Debug
end # module SE

# vim: sw=2 ts=2 et ai nowrap bg=dark

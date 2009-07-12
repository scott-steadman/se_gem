# http://probablycorey.wordpress.com/2008/03/28/abusing-rubys-question-mark-methods/
#
# Takes an object as a parameter and will invert the return values of all its
# methods.
#
class Negator
  def initialize(object)
    @object = object
  end

  def method_missing(symbol, *args)
    !@object.send(symbol, *args)
  end
end

class Object
  def not
    Negator.new(self)
  end
end

require 'test/unit'
require "#{File.dirname(__FILE__)}/../../lib/se/aspect"

class AspectTest < Test::Unit::TestCase

  class Foo < Array
  end


  # need to do all tests at once or we'll have side effects between tests
  def test_aspect
    before_class    = false
    before_instance = false
    after_instance  = false
    after_class     = false

    SE::Aspect.define do
      with_class(Foo).before(:new) do |klass|
        before_class = true
      end

      with_instance_of(Foo).before(:empty?) do |instance|
        before_instance = true
      end

      with_class(Foo).after(:new) do |klass|
        after_instance = true
      end

      with_instance_of(Foo).after(:empty?) do |instance|
        after_class = true
      end
    end

    Foo.new.empty?
    assert_equal true, before_class, 'before class method failed'
    assert_equal true, after_class, 'after class method failed'
    assert_equal true, before_instance, 'before instance method failed'
    assert_equal true, after_instance, 'after instance method failed'
  end

end


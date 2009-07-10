module Benchmark
  # from: http://blog.pluron.com/2008/01/guerrillas-way.html
  # optimization to prevent unnecessary object creation
  def realtime
    r0 = Time.now
    yield
    r1 = Time.now
    r1.to_f - r0.to_f
  end
  module_function :realtime
end

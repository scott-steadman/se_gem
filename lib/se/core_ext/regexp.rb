class Regexp

  def blank?
    false
  end

  #
  # Allow a Regexp to be used instead of an Array for matching a value.
  #
  # Instead of:
  #   ['a-1','a-2'].include?(value)
  #
  # We can:
  #   /a-[12]/.include?(value)
  #
  def include?(value)
    not match(value.to_s).nil?
  end

end

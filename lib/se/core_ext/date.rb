require 'date'

class Date

  # returns the number of days in the year
  def days_in_year
    leap? ? 366 : 365
  end

end

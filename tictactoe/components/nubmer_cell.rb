require_relative './cell'

class NumberCell < Cell
  def initialize(number)
    @number = number
  end

  def draw
    [
      '       ',
      "   #{@number}   ",
      '       '
    ]

  end
end

require_relative './border_decorator'

class RightBorderDecorator < BorderDecorator
  def draw
    @cell.draw.map do |row|
      row + '|'
    end
  end
end

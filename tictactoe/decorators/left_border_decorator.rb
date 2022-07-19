require_relative './border_decorator'

class LeftBorderDecorator < BorderDecorator
  def draw
    @cell.draw.map do |row|
      '|' + row
    end
  end
end

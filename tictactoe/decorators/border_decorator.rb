require_relative './../components/cell'

class BorderDecorator < Cell
  def initialize(cell)
    @cell = cell
  end

  def draw
    raise NotImplementedError
  end
end

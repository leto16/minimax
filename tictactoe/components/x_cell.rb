require_relative './cell'

class XCell < Cell
  def draw
    [
      '  \ /  ',
      '   X   ',
      '  / \  '
    ]
  end
end
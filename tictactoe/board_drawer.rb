Dir[File.join(__dir__, 'components', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'decorators', '*.rb')].each { |file| require_relative file }

class BoardDrawer
  NUMBER_TO_INDEX = {
    1 => [0,0],
    2 => [0,1],
    3 => [0,2],
    4 => [1,0],
    5 => [1,1],
    6 => [1,2],
    7 => [2,0],
    8 => [2,1],
    9 => [2,2]
  }

  NUMBER_TO_BORDERS = {
    1 => [:bottom, :right],
    2 => [:bottom, :right, :left],
    3 => [:bottom, :left],
    4 => [:top, :bottom, :right],
    5 => [:top, :bottom, :left, :right],
    6 => [:top, :bottom, :left],
    7 => [:top, :right],
    8 => [:top, :right, :left],
    9 => [:top, :left]
  }

  def initialize(board)
    @board = board
  end

  def paint
    paint_1_row
    paint_2_row
    paint_3_row
  end

  private

  def paint_1_row
    puts combine_cells(cell_n(1), cell_n(2), cell_n(3))
  end

  def paint_2_row
    puts combine_cells(cell_n(4), cell_n(5), cell_n(6))
  end

  def paint_3_row
    puts combine_cells(cell_n(7), cell_n(8), cell_n(9))
  end

  def cell_n(n)
    i, j = NUMBER_TO_INDEX[n]
    cell_value = @board[i][j]

    case cell_value
    when :x
      decorate_cell(n, XCell.new)
    when :o
      decorate_cell(n, OCell.new)
    when nil
      decorate_cell(n, NumberCell.new(n))
    end
  end

  def decorate_cell(n, base_cell)
    NUMBER_TO_BORDERS[n].reduce(base_cell) { |acc, direction| decorator_const(direction).new(acc) }
  end

  def decorator_const(direction)
    Kernel.const_get("#{direction.to_s.capitalize}BorderDecorator")
  end

  def combine_cells(c1, c2, c3)
    c1.draw.map.with_index do |row, i|
      row + c2.draw[i] + c3.draw[i] + "\n"
    end
  end
end
require_relative './border_decorator'

class BottomBorderDecorator < BorderDecorator
  def draw
    border_length = cell_form.last.length

    cell_form.concat(['_' * border_length])
  end

  private

  def cell_form
    @cell_form ||= @cell.draw
  end
end

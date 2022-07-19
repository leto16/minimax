require_relative './border_decorator'

class TopBorderDecorator < BorderDecorator
  def draw
    border_length = cell_form.first.length

    (['-' * border_length]).concat(cell_form)
  end

  private

  def cell_form
    @cell_form ||= @cell.draw
  end
end

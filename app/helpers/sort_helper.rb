module SortHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column[sort_column] && sort_direction == 'asc' ? 'desc' : 'asc'
    arrow = { 'desc' => '▴', 'asc' => '▾' }[direction] if column == sort_column
    title += " #{arrow}"

    button_to title.strip, request.path, method: :patch, params: {
      c: column, d: direction, q: params[:q], page: params[:page]
    }
  end

  def sort_direction
    direction = params[:d]
    %w(asc desc).include?(direction) ? direction : 'asc'
  end
end

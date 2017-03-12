module ProjectCalendarHelper
  def project_calendar(yearmonth, stand_ups)
    @month = Date.new(*yearmonth)
    @stand_ups = stand_ups
    project_table
  end

  HEADER = %w(S M T W T F S)
  START_DAY = :sunday

  def project_table
    <<-HTML.html_safe
    <table class="calendar">
      #{header}#{project_week_rows}
    </table>
    HTML
  end

  def project_week_rows
    weeks.map do |week|
      <<-HTML
        <tr>
          #{week.map { |day| project_day_cell(day) }.join}
        </tr>
      HTML
    end.join
  end

  def project_day_cell(day)
    s = @stand_ups.find { |x| x.date == day }
    button = if s
      <<-HTML
        <a class="expand" role="button" data-toggle="popover" tabindex="0" title="Day" data-content='#{edit_stand_up s}#{delete_stand_up s}'></a>
      HTML
    else
      nil
    end

    <<-HTML
      <td class="#{project_day_classes day, s}">
        #{day.day}#{button}
      </td>
    HTML
  end

  def edit_stand_up(s) # s for stand_up
    p_id = params[:project_id]

    <<-HTML
      <a class="link" href="/projects/#{p_id}/stand_ups/#{s.date}/edit">Edit</a>
    HTML
  end

  def delete_stand_up(stand_up)
    p_id = params[:project_id]
    <<-HTML
      <a class="link" data-confirm="Delete this record?" rel="nofollow" data-method="delete" href="/projects/#{p_id}/stand_ups/#{stand_up.date}">Delete</a>
    HTML
  end

  def project_day_classes(day, stand_up)
    classes = []
    classes << 'today' if day == Date.today
    classes << 'notmonth' if day.month != @month.month
    classes << 'present' if stand_up
    classes.empty? ? nil : classes.join(' ')
  end
end

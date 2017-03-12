module AttendanceCalendarHelper
  def attendance_calendar(yearmonth, attendances)
    @month = Date.new(*yearmonth)
    @attendances = attendances
    attendance_table
  end

  HEADER = %w(S M T W T F S)
  START_DAY = :sunday

  def attendance_table
    <<-HTML.html_safe
    <table class="calendar">
      #{header}#{attendance_week_rows}
    </table>
    HTML
  end

  def header
    <<-HTML
      <thead>
        <tr><th colspan="7">#{@month.strftime('%B %Y')}</td></tr>
        <tr>#{HEADER.map { |day| "<th>#{day}</th>" }.join }</tr>
      </thead>
    HTML
  end

  def attendance_week_rows
    weeks.map do |week|
      <<-HTML
      <tr>
        #{week.map { |day| attendance_day_cell(day) }.join}
      </tr>
      HTML
    end.join
  end

  def weeks
    first = @month.beginning_of_week(START_DAY)
    last = @month.change(day: -1).end_of_week(START_DAY)
    (first..last).to_a.in_groups_of(7)
  end

  def attendance_day_cell(day)
    a = @attendances.find { |x| x.date == day }

    button = if a
      <<-HTML
        <a class="expand" role="button" data-toggle="popover" tabindex="0" title="Day" data-content='#{edit_attendance a}#{delete_attendance a}'></a>
      HTML
    else
      nil
    end

    <<-HTML
      <td class="#{attendance_day_classes day, a}">
        #{day.day}#{button}
      </td>
    HTML
  end

  def edit_attendance(a)
    s = a.semester

    <<-HTML
      <a class="link" href="/courses/#{s.course_id}/semesters/#{s.id}/attendance?date=#{a.date}">Edit</a>
    HTML
  end

  def delete_attendance(attendance)
    <<-HTML
      <a class="link" data-confirm="Delete this record?" rel="nofollow" data-method="delete" href="/attendances/#{attendance.id}">Delete</a>
    HTML
  end

  def attendance_day_classes(day, attendance)
    classes = []
    classes << 'today' if day == Date.today
    classes << 'notmonth' if day.month != @month.month
    classes << { true => 'present', false => 'absent' }[attendance&.present]
    classes.empty? ? nil : classes.join(' ')
  end
end

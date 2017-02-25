module CalendarHelper
  def calendar(yearmonth, attendances)
    @month = Date.new *yearmonth
    @attendances = attendances
    table
  end

  HEADER = %w(S M T W T F S)
  START_DAY = :sunday

  def table
    <<-HTML.html_safe
    <table class="calendar">
      #{header}#{week_rows}
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

  def week_rows
    weeks.map do |week|
      <<-HTML
      <tr>
        #{week.map { |day| day_cell(day) }.join}
      </tr>
      HTML
    end.join
  end

  def weeks
    first = @month.beginning_of_week(START_DAY)
    last = @month.change(day: -1).end_of_week(START_DAY)
    (first..last).to_a.in_groups_of(7)
  end

  def day_cell(day)
    attendance = @attendances.find { |x| x.date == day }
    button = if attendance
      link = link_to 'Delete', attendance, class: 'link', data: { confirm: 'Delete this record?' }, method: :delete
      link.gsub!('"', "'")

      <<-HTML
        <a class="delete" role="button" data-toggle="popover" tabindex="0" title="Day" data-content="#{link}"></a>
      HTML
    else
      nil
    end

    <<-HTML
      <td class="#{day_classes(day, attendance)}">
        #{day.day}#{button}
      </td>
    HTML
  end

  def day_classes(day, attendance)
      classes = []
      classes << 'today' if day == Date.today
      classes << 'notmonth' if day.month != @month.month
      classes << { true => 'present', false => 'absent' }[attendance&.present]
      classes.empty? ? nil : classes.join(' ')
    end
end

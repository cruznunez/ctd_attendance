module StudentsHelper
  def attendance_percentage(total)
    present = total.select &:present
    percent = (present.size/total.size.to_f * 100).round rescue 0
  end

  def semester_attendance(semester, attendances)
    present = attendances.select &:present
    percent = (present.size/attendances.size.to_f * 100).round rescue 0
    link_to course_semester_path(semester.course_id, semester), class: 'attendance', style: "width: #{percent}%" do
      <<-HTML.html_safe
        <span>#{semester.course.name} | #{semester.name}</span>
        <span>#{percent}%</span>
      HTML
    end
  end

  def student_attendance(student, semester)
    total = student.attendances.select { |x| x.semester_id == semester.id }
    percent = attendance_percentage total
    link_to student, class: 'attendance', style: "width: #{percent}%" do
      <<~HTML.html_safe
        #{student.first_name}
        <span>#{percent}%</span>
      HTML
    end
  end

  def student_info(student, name)
    <<~HTML.html_safe
      <h4 class="card-title">#{name.to_s.titleize}</h4>

      <p class="card">#{@student.send(name) || '<i>missing</i>'}</p>
    HTML
  end
end

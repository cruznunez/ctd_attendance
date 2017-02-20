module StudentsHelper
  def semester_attendance(semester, attendances)
    present = attendances.select &:present
    percent = (present.count/attendances.count.to_f * 100).round rescue 0
    link_to course_semester_path(semester.course_id, semester), class: 'attendance', style: "width: #{percent}%" do
      <<-HTML.html_safe
        <span>#{semester.course.name} | #{semester.name}</span>
        <span>#{percent}%</span>
      HTML
    end
  end

  def student_attendance(student)
    total = student.attendances.select { |x| x.semester_id == @semester.id }
    present = total.select &:present
    percent = (present.size/total.size.to_f * 100).round rescue 0
    link_to student, class: 'attendance', style: "width: #{percent}%" do
      <<-HTML.html_safe
        <span>#{student.first_name}</span>
        <span>#{percent}%</span>
      HTML
    end
  end
end

class AbsenceMailer < ApplicationMailer
  def student(attendance_id)
    @attendance = Attendance.find attendance_id
    @student = @attendance.student

    mail to: @student.email, subject: '[Alert] Absence'
  end

  def teacher_assistant(semester_id, attendance_ids)
    @semester = Semester.find semester_id
    @teacher_assistant = @semester.teacher_assistant

    return unless @teacher_assistant

    attendances = Attendance.includes(:student).where id: attendance_ids

    @students = attendances.map(&:student)

    mail to: @teacher_assistant.email, subject: '[Alert] Student Absent'
  end

  def director(semester_id, attendance_ids)
    @semester = Semester.find semester_id
    @director = @semester.director

    return unless @director

    attendances = Attendance.includes(:student).where id: attendance_ids

    @students = attendances.map(&:student)

    mail to: @director.email, subject: '[Alert] Student Absent'
  end
end

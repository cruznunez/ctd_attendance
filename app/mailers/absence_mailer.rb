class AbsenceMailer < ApplicationMailer
  def student(attendance_id)
    @attendance = Attendance.find attendance_id
    @student = @attendance.student

    mail to: @student.email, subject: '[Alert] Absence'
  end

  def teacher_assistant(attendance_id)
    @attendance = Attendance.find attendance_id
    @student = @attendance.student
    @semester = @attendance.semester
    @teacher_assistant = @semester.teacher_assistant

    return unless @teacher_assistant

    mail to: @teacher_assistant.email, subject: '[Alert] Student Absent'
  end

  def director(attendance_id)
    @attendance = Attendance.find attendance_id
    @student = @attendance.student
    @semester = @attendance.semester
    @director = @semester.director

    return unless @director

    mail to: @director.email, subject: '[Alert] Student Absent'
  end
end

class AbsenceJob < ApplicationJob
  queue_as :default

  def perform(semester_id, date)
    semester = Semester.find semester_id
    absences = semester.attendances.where date: date, present: false
    consecutive = absences.select &:consecutive?
    unconsecutive = absences - consecutive

    # first, send an email to all the absent students
    absences.each do |absence|
      AbsenceMailer.student(absence.id).deliver_now
    end

    # then, send 1 email to teacher assistant of all the unconsecutive absences
    AbsenceMailer.teacher_assistant(semester_id, unconsecutive.map(&:id))
                 .deliver_now

    # then, send 1 email to director of all the consecutive absences
    AbsenceMailer.director(semester_id, consecutive.map(&:id))
                 .deliver_now
  end
end

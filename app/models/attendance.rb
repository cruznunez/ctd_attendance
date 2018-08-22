class Attendance < ApplicationRecord
  belongs_to :semester
  belongs_to :student

  validates_presence_of :date, :semester

  after_create :send_emails

  def absent?
    !present?
  end

  def consecutive?
    return if self.present?
    # now that we know that this attendance was absent,
    # let's look at the last attendance of this student
    student.attendances
           .where("semester_id = ? AND date < ?", semester.id, self.date)
           .order(:date)
           .last
           &.absent?
  end

  def email_director
    AbsenceMailer.director(id)
                 .deliver_later wait_until: email_wait_time
  end

  def email_student
    AbsenceMailer.student(id)
                 .deliver_later wait_unitl: email_wait_time
  end

  def email_teacher_assistant
    AbsenceMailer.teacher_assistant(id)
                 .deliver_later wait_until: email_wait_time
  end

  def email_wait_time
    # Date.tomorrow + 8.hours
    Time.now + 1.minute
  end

  private

  # if the date of the attendance matches today's date
  # if the student was absent, send them an email and the Teacher Assistant
  # if the absence was consecutive, send them an email and the Director
  def send_emails
    return unless absent? && date == Date.today

    # always send email to student
    email_student

    # if the absence was consecutive?
    if consecutive?
      email_teacher_assistant
    else
      email_director
    end
  end
end

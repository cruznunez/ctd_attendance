# Preview all emails at http://localhost:3000/rails/mailers/absence
class AbsencePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/absence/student
  def student
    AbsenceMailer.student
  end

  # Preview this email at http://localhost:3000/rails/mailers/absence/teacher_assistant
  def teacher_assistant
    AbsenceMailer.teacher_assistant
  end

  # Preview this email at http://localhost:3000/rails/mailers/absence/director
  def director
    AbsenceMailer.director
  end

end

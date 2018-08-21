class AbsenceMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.absence_mailer.student.subject
  #
  def student
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.absence_mailer.teacher_assistant.subject
  #
  def teacher_assistant
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.absence_mailer.director.subject
  #
  def director
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end

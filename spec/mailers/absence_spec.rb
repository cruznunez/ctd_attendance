require "rails_helper"
include ActiveJob::TestHelper

RSpec.describe AbsenceMailer, type: :mailer do
  before do
    @student = create :student
    @course = create :course
    @semester = create :semester
    @attendance = create :attendance
  end

  describe 'student' do
    let(:mail) { AbsenceMailer.student @attendance.id }

    context 'general' do
      it 'renders the headers' do
        mail.subject.should eq '[Alert] Absence'
        mail.to.should eq [@student.email]
        mail.from.should eq ['noreply@codethedream.app']
      end
    end

    context 'html' do
      let(:html) { get_message_part mail, /html/ }

      it 'renders salutation and student name' do
        html.should match "Hello #{@student.name}"
      end

      it 'renders message' do
        html.should match "We missed you in class yesterday! If you are receiving this email in error and you were in class yesterday, please contact your instructor. Otherwise, we hope to see you next time!"
      end

      it 'renders closing' do
        html.should match 'Best,'
        html.should match 'Code The Dream'
      end
    end

    context 'plain' do
      let(:plain) { get_message_part mail, /plain/ }

      it 'renders student name' do
        plain.should match @student.name
      end

      it 'renders message' do
        plain.should match "We missed you in class yesterday! If you are receiving this email in error and you were in class yesterday, please contact your instructor. Otherwise, we hope to see you next time!"
      end
    end
  end

  describe 'teacher_assistant' do
    let(:mail) { AbsenceMailer.teacher_assistant @semester.id, [@attendance.id] }

    context 'no teacher assistant' do
      it 'does nothing' do
        mail.subject.should eq nil
        mail.to.should eq nil
        mail.from.should eq nil
      end
    end

    context 'with teacher assistant' do
      before do
        @teacher_assistant = create :user
        @semester.update teacher_assistant: @teacher_assistant
      end

      context 'general' do
        it 'renders the headers' do
          mail.subject.should eq '[Alert] Student Absent'
          mail.to.should eq [@teacher_assistant.email]
          mail.from.should eq ['noreply@codethedream.app']
        end
      end

      context 'html' do
        let(:html) { get_message_part mail, /html/ }

        it 'renders Teacher Assistant' do
          html.should match 'Hello Teacher Assistant,'
        end

        it "renders the body" do
          html.should match "You are receiving this email because 1 student in #{@course.name} - #{@semester.name} was absent in yesterday's class. You must do something about this. Do it."
        end

        it 'renders the list of students' do
          html.should match 'The students are:'
          html.should match "<li>#{@student.name}</li>"
        end

        it 'renders student emails' do
          html.should match "Their emails are: #{@student.email}"
        end
      end

      context 'plain' do
        let(:plain) { get_message_part mail, /plain/ }

        it 'renders Teacher Assistant' do
          plain.should match 'Hello Teacher Assistant'
        end

        it 'renders the body' do
          plain.should match "You are receiving this email because 1 student in #{@course.name} - #{@semester.name} was absent in yesterday's class. You must do something about this. Do it."
        end

        it 'renders the list of students' do
          plain.should match 'The students are:'
          plain.should match "- #{@student.name}"
        end

        it 'renders student emails' do
          plain.should match "Their emails are: #{@student.email}"
        end
      end
    end
  end

  describe 'director' do
    let(:mail) { AbsenceMailer.director @semester.id, [@attendance.id] }

    context 'no director' do
      it 'does nothing' do
        mail.subject.should eq nil
        mail.to.should eq nil
        mail.from.should eq nil
      end
    end

    context 'with director' do
      before do
        @director = create :user
        @semester.update director: @director
      end

      context 'general' do
        it 'renders the headers' do
          mail.subject.should eq '[Alert] Student Absent'
          mail.to.should eq [@director.email]
          mail.from.should eq ['noreply@codethedream.app']
        end
      end

      context 'html' do
        let(:html) { get_message_part mail, /html/ }

        it 'renders Teacher Assistant' do
          html.should match 'Hello Director,'
        end

        it "renders the body" do
          html.should match "You are receiving this email because 1 student in #{@course.name} - #{@semester.name} was absent in yesterday's class. You must do something about this. Do it."
        end

        it 'renders the list of students' do
          html.should match 'The students are:'
          html.should match "<li>#{@student.name}</li>"
        end

        it 'renders student emails' do
          html.should match "Their emails are: #{@student.email}"
        end
      end

      context 'plain' do
        let(:plain) { get_message_part mail, /plain/ }

        it 'renders Director' do
          plain.should match 'Hello Director'
        end

        it 'renders the body' do
          plain.should match "You are receiving this email because 1 student in #{@course.name} - #{@semester.name} was absent in yesterday's class. You must do something about this. Do it."
        end

        it 'renders the list of students' do
          plain.should match 'The students are:'
          plain.should match "- #{@student.name}"
        end

        it 'renders student emails' do
          plain.should match "Their emails are: #{@student.email}"
        end
      end
    end
  end
end

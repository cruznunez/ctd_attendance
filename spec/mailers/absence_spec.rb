require "rails_helper"

RSpec.describe AbsenceMailer, type: :mailer do
  describe "student" do
    let(:mail) { AbsenceMailer.student }

    it "renders the headers" do
      expect(mail.subject).to eq("Student")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "teacher_assistant" do
    let(:mail) { AbsenceMailer.teacher_assistant }

    it "renders the headers" do
      expect(mail.subject).to eq("Teacher assistant")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "director" do
    let(:mail) { AbsenceMailer.director }

    it "renders the headers" do
      expect(mail.subject).to eq("Director")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

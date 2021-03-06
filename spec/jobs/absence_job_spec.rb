require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe AbsenceJob, type: :job do
  def deliveries
    ActionMailer::Base.deliveries
  end

  before do
    # create 3 students
    @s1 = create :student
    @s2 = create :student, 2
    @s3 = create :student, 3

    @teacher_assistant = create :user
    @director = create :user, 2

    create :course
    @semester = create :semester, teacher_assistant: @teacher_assistant, director: @director

    @date = Date.today

  end

  let(:job) { described_class }

  context '2 students absent, 1 consecutive' do
    before do
      # clear all mail before starting tests
      deliveries.clear

      # take attendance of students for 1 week ago
      create :attendance, date: @date - 1.week, student: @s1, present: true
      create :attendance, date: @date - 1.week, student: @s2, present: true
      create :attendance, date: @date - 1.week, student: @s3, present: false

      # take attendance of students for today
      create :attendance, date: @date, student: @s1, present: true
      create :attendance, date: @date, student: @s2, present: false
      create :attendance, date: @date, student: @s3, present: false
    end

    it 'sends 2 emails to students, 2 emails to staff' do
      expect do
        job.perform_now(@semester.id, @date)
      end.to change(deliveries, :size).by 4

      deliveries[0].to.should eq [@s2.email]
      deliveries[1].to.should eq [@s3.email]
      deliveries[2].to.should eq [@teacher_assistant.email]
      deliveries[3].to.should eq [@director.email]
    end
  end

  context '2 students absent, 2 consecutive' do
    before do
      # clear all mail before starting tests
      deliveries.clear

      # take attendance of students for 1 week ago
      create :attendance, date: @date - 1.week, student: @s1, present: true
      create :attendance, date: @date - 1.week, student: @s2, present: false
      create :attendance, date: @date - 1.week, student: @s3, present: false

      # take attendance of students for today
      create :attendance, date: @date, student: @s1, present: true
      create :attendance, date: @date, student: @s2, present: false
      create :attendance, date: @date, student: @s3, present: false
    end

    it 'sends 2 emails to students, 2 emails to staff' do
      expect do
        job.perform_now @semester.id, @date
      end.to change(deliveries, :size).by 3

      deliveries[0].to.should eq [@s2.email]
      deliveries[1].to.should eq [@s3.email]
      deliveries[2].to.should eq [@director.email]
    end
  end

  context '2 students absent, 2 unconsecutive' do
    before do
      # clear all mail before starting tests
      deliveries.clear

      # take attendance of students for today
      create :attendance, date: @date, student: @s1, present: true
      create :attendance, date: @date, student: @s2, present: false
      create :attendance, date: @date, student: @s3, present: false
    end

    it 'sends 2 emails to students, 2 emails to staff' do
      expect do
        job.perform_now @semester.id, @date
      end.to change(deliveries, :size).by 3

      deliveries[0].to.should eq [@s2.email]
      deliveries[1].to.should eq [@s3.email]
      deliveries[2].to.should eq [@teacher_assistant.email]
    end
  end
end

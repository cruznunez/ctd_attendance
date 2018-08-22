# frozen_string_literal: false

require 'rails_helper'
include ActiveJob::TestHelper

describe Attendance, type: :model do
  before do
    @user1 = create :user
    @user2 = create :user, 2
    @user3 = create :user, 3
    @student = create :student
    @course = create :course
    @semester = create :semester,
                       teacher: @user1,
                       teacher_assistant: @user2,
                       director: @user3
  end

  after do
  end

  context 'Associations' do
    describe 'Semester' do
      it 'belongs_to :semester' do
        attendance = build :attendance, semester: @semester
        attendance.semester.should eq @semester
      end
    end

    describe 'Student' do
      it 'belongs_to :student' do
        attendance = build :attendance, student: @student
        attendance.student = @student
      end
    end
  end

  context 'Delegations' do
  end

  context 'Factories' do
    it 'has a valid factory' do
      attendance = build :attendance
      attendance.should be_valid
      assert attendance.save
    end
  end

  context 'Instance Methods' do
    describe ':absent?' do
      context 'present: true' do
        before do
          @attendance = build :attendance, present: true
        end

        it 'returns false' do
          refute @attendance.absent?
        end
      end

      context 'present: false' do
        before do
          @attendance = build :attendance, present: false
        end

        it 'returns true' do
          assert @attendance.absent?
        end
      end
    end

    describe ':consecutive?' do
      before do
        @today = Date.today
      end

      context 'present: true' do
        before do
          create :attendance, date: @today - 1.week, present: false
        end

        it 'returns false' do
          a1 = create :attendance, date: @today, present: true
          refute a1.consecutive?
        end
      end

      context 'present: false' do
        context 'empty database' do
          it 'is not consecutive' do
            Attendance.count.should eq 0
            a1 = create :attendance, date: @today, present: false
            refute a1.consecutive?
          end
        end

        context '1 past date, present: true record in database' do
          before do
            create :attendance, date: @today - 1.week, present: true
          end

          it 'is not consecutive' do
            a1 = create :attendance, date: @today, present: false
            refute a1.consecutive?
          end
        end

        context '1 past absent record in database' do
          before do
            create :attendance, date: @today - 1.week, present: false
          end

          it 'is consecutive' do
            a1 = create :attendance, date: @today, present: false
            assert a1.consecutive?
          end
        end

        context '2 records in database, out of order. prev is absent' do
          before do
            create :attendance, date: @today - 1.week, present: false
            create :attendance, date: @today - 2.weeks, present: true
          end

          it 'is consecutive' do
            a1 = create :attendance, date: @today, present: false
            assert a1.consecutive?
          end
        end

        context '2 records in database, out of order, prev is present' do
          before do
            create :attendance, date: @today - 1.week, present: true
            create :attendance, date: @today - 2.weeks, present: false
          end

          it 'is consecutive' do
            a1 = create :attendance, date: @today, present: false
            refute a1.consecutive?
          end
        end
      end
    end

    describe ':email_director' do
      before do
        @attendance = build :attendance
      end

      it 'sends an email' do
        expect do
          expect do
            @attendance.email_director
          end.to change(enqueued_jobs, :size).by 1
        end.to have_enqueued_job.on_queue 'mailers'
      end
    end

    describe ':email_student' do
      before do
        @attendance = build :attendance
      end

      it 'sends an email' do
        expect do
          expect do
            @attendance.email_student
          end.to change(enqueued_jobs, :size).by 1
        end.to have_enqueued_job.on_queue 'mailers'
      end
    end

    describe ':email_teacher_assistant' do
      before do
        @attendance = build :attendance
      end

      it 'sends an email' do
        expect do
          expect do
            @attendance.email_teacher_assistant
          end.to change(enqueued_jobs, :size).by 1
        end.to have_enqueued_job.on_queue 'mailers'
      end
    end
  end

  context 'Validations' do
    describe ':date' do
      it 'presence: true' do
        a1 = build :attendance, date: nil
        a2 = build :attendance, date: Date.today

        a1.should_not be_valid
        a2.should be_valid

        a1.errors.to_a.should eq ["Date can't be blank"]
        a2.errors.to_a.should eq []

        refute a1.save
        assert a2.save
      end
    end

    describe ':semester_id' do
      it 'presence: true' do
        a1 = build :attendance, semester: nil
        a2 = build :attendance, semester: @semester

        a1.should_not be_valid
        a2.should be_valid

        a1.errors.to_a.should eq ["Semester can't be blank"]
        a2.errors.to_a.should eq []

        refute a1.save
        assert a2.save
      end
    end
  end
end

# frozen_string_literal: false

require 'rails_helper'

describe Semester, type: :model do
  before do
    @student = create :student
    @course = create :course
    @semester = create :semester
  end

  after do
  end

  context 'Associations' do
    before do
      @user = create :user
    end

    describe 'Director' do
      it 'belongs_to :director' do
        semester = build :semester, director: @user
        semester.director.should eq @user
      end
    end

    describe 'Lesson' do
      it 'has_many :lessons' do
        l1 = create :lesson
        @semester.lessons.should eq [l1]

        l2 = create :lesson
        @semester.reload
        @semester.lessons.should match_array [l1, l2]
      end

      it 'dependent: :destroy' do
        expect do
          l1 = create :lesson
        end.to change(Lesson, :count).by 1

        expect do
          @semester.destroy
        end.to change(Lesson, :count).by -1
      end
    end

    describe 'Teacher' do
      it 'belongs_to :teacher' do
        semester = build :semester, teacher: @user
        semester.teacher.should eq @user
      end
    end

    describe 'Teacher Assistant' do
      it 'belongs_ot :teacher_assistant' do
        semester = build :semester, teacher_assistant: @user
        semester.teacher_assistant.should eq @user
      end
    end
  end

  context 'Delegations' do
  end

  context 'Factories' do
    it 'has a valid factory' do
      attendance = build :semester
      attendance.should be_valid
      assert attendance.save
    end
  end

  context 'Instance Methods' do
  end

  context 'Validations' do
    describe ':course_id' do
      it 'presence: true' do
        s1 = build :semester, course: nil
        s2 = build :semester, course: @course

        s1.should_not be_valid
        s2.should be_valid

        s1.errors.to_a.should eq ["Course can't be blank"]
        s2.errors.to_a.should eq []

        refute s1.save
        assert s2.save
      end
    end

    describe ':name' do
      it 'presence: true' do
        s1 = build :semester, name: nil
        s2 = build :semester, name: 'my string'

        s1.should_not be_valid
        s2.should be_valid

        s1.errors.to_a.should eq ["Name can't be blank"]
        s2.errors.to_a.should eq []

        refute s1.save
        assert s2.save
      end
    end
  end
end

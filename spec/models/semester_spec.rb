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
  end
end

require 'rails_helper'

RSpec.describe Lesson, type: :model do
  before do
    create :course
    @semester = create :semester
  end

  context 'Associations' do
    describe 'Semester' do
      it 'belongs_to :semester' do
        lesson = build :lesson, semester: @semester
        lesson.semester.should eq @semester
      end
    end
  end

  context 'Factories' do
    it 'has a valid factory' do
      lesson = build :lesson
      lesson.should be_valid
      assert lesson.save
    end
  end

  context 'Validations' do
    describe ':semester' do
      it 'presence: true' do
        l1 = build :lesson, semester: nil
        l2 = build :lesson, semester: @semester

        l1.should_not be_valid
        l2.should be_valid

        l1.errors.to_a.should eq ["Semester can't be blank"]
        l2.errors.to_a.should eq []

        refute l1.save
        assert l2.save
      end
    end
  end
end

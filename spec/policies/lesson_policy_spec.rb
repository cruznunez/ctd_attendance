require 'rails_helper'

RSpec.describe LessonPolicy do
  let(:policy) { described_class }

  before do
    @student = create :student
    @user = create :user, teacher: false
    @teacher = create :user, 2, teacher: true
  end

  # NOTE: CRUD

  permissions :index? do
    context 'student' do
      it 'grants access' do
        policy.should permit @student
      end
    end

    context 'user' do
      it 'denies access if not teacher' do
        policy.should_not permit @user
      end

      it 'grants access if teacher' do
        policy.should permit @teacher
      end
    end

    it 'denies access if not logged in' do
      policy.should_not permit nil
    end
  end

  permissions :new? do
    context 'student' do
      it 'denies access' do
        policy.should_not permit @student
      end
    end

    context 'user' do
      it 'denies access if not teacher' do
        policy.should_not permit @user
      end

      it 'grants access if teacher' do
        policy.should permit @teacher
      end
    end

    it 'denies access if not logged in' do
      policy.should_not permit nil
    end
  end

  permissions :create? do
    context 'student' do
      it 'denies access' do
        policy.should_not permit @student
      end
    end

    context 'user' do
      it 'denies access if not teacher' do
        policy.should_not permit @user
      end

      it 'grants access if teacher' do
        policy.should permit @teacher
      end
    end

    it 'denies access if not logged in' do
      policy.should_not permit nil
    end
  end

  permissions :show? do
    before do
      create :course
      create :semester
      @lesson = create :lesson
    end

    context 'student' do
      context 'lesson is visible' do
        before do
          @lesson.update visible: true
        end

        it 'grants access' do
          policy.should permit @student, @lesson
        end
      end

      context 'lesson is not visible' do
        before do
          @lesson.update visible: false
        end

        it 'denies access' do
          policy.should_not permit @student, @lesson
        end
      end

      context 'lesson is not provided' do
        before do
          @lesson.update visible: true
        end

        it 'denies access' do
          policy.should_not permit @student
        end
      end
    end

    context 'user' do
      it 'denies access if not teacher' do
        policy.should_not permit @user
      end

      it 'grants access if teacher' do
        policy.should permit @teacher
      end
    end

    it 'denies access if not logged in' do
      policy.should_not permit nil
    end
  end

  permissions :edit? do
    context 'student' do
      it 'denies access' do
        policy.should_not permit @student
      end
    end

    context 'user' do
      it 'denies access if not teacher' do
        policy.should_not permit @user
      end

      it 'grants access if teacher' do
        policy.should permit @teacher
      end
    end

    it 'denies access if not logged in' do
      policy.should_not permit nil
    end
  end

  permissions :update? do
    context 'student' do
      it 'denies access' do
        policy.should_not permit @student
      end
    end

    context 'user' do
      it 'denies access if not teacher' do
        policy.should_not permit @user
      end

      it 'grants access if teacher' do
        policy.should permit @teacher
      end
    end

    it 'denies access if not logged in' do
      policy.should_not permit nil
    end
  end

  permissions :destroy? do
    context 'student' do
      it 'denies access' do
        policy.should_not permit @student
      end
    end

    context 'user' do
      it 'denies access if not teacher' do
        policy.should_not permit @user
      end

      it 'grants access if teacher' do
        policy.should permit @teacher
      end
    end

    it 'denies access if not logged in' do
      policy.should_not permit nil
    end
  end

  # NOTE: SPECIAL

  permissions :slides? do
    context 'student' do
      it 'grants access' do
        policy.should permit @student
      end
    end

    context 'user' do
      it 'denies access if not teacher' do
        policy.should_not permit @user
      end

      it 'grants access if teacher' do
        policy.should permit @teacher
      end
    end

    it 'denies access if not logged in' do
      policy.should_not permit nil
    end
  end
end

class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def teacher?
    @user.is_a?(User) && @user.teacher
  end

  def student?
    @user.is_a? Student
  end

  def student_or_teacher?
    student? || teacher?
  end

  %i(new? create? show? edit? update? destroy?).each do |ali|
    alias_method ali, :teacher?
  end

  %i(index?).each do |ali|
    alias_method ali, :student_or_teacher?
  end
end

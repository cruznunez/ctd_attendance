class LessonPolicy < ApplicationPolicy
  def student?
    @user.is_a? Student
  end

  def teacher?
    @user.is_a?(User) && @user.teacher?
  end

  def student_or_teacher?
    student? || teacher?
  end

  %i(index? show? slides?).each do |ali|
    alias_method ali, :student_or_teacher?
  end

  %i(new? create? edit? update? destroy?).each do |ali|
    alias_method ali, :teacher?
  end
end

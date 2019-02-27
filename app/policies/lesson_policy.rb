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

  def visible?
    @record.is_a?(Lesson) && @record.visible?
  end

  def visible_to_person?
    (student? && visible?) || teacher?
  end

  def slides_name?
    true
  end

  %i(show?).each do |ali|
    alias_method ali, :visible_to_person?
  end

  %i(index? slides?).each do |ali|
    alias_method ali, :student_or_teacher?
  end

  %i(new? create? edit? update? destroy?).each do |ali|
    alias_method ali, :teacher?
  end
end

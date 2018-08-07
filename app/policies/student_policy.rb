class StudentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def teacher?
    @user.is_a?(User) && @user.teacher
  end

  def student?
    @user == @record
  end

  def this_student_or_teacher?
    student? || teacher?
  end

  # %i(index? show?).each do |name|
  #   define_method name { true }
  # end

  %i(index? new? create? show? edit? destroy?).each do |ali|
    alias_method ali, :teacher?
  end

  %i(change_password?).each do |ali|
    alias_method ali, :student?
  end

  %i(update?).each do |ali|
    alias_method ali, :this_student_or_teacher?
  end
end

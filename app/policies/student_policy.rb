class StudentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def teacher?
    @user.teacher
  end

  # %i(index? show?).each do |name|
  #   define_method name { true }
  # end

  %i(index? new? create? show? edit? update? destroy?).each do |ali|
    alias_method ali, :teacher?
  end
end

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def teacher?
    @user.is_a?(User) && @user.teacher
  end

  %i(index? new? create? show? edit? update? destroy?).each do |ali|
    alias_method ali, :teacher?
  end
end

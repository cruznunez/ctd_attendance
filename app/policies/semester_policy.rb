class SemesterPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def teacher?
    @user.teacher
  end

  %i(index? new? create? show? edit? update? destroy? attendance?).each do |ali|
    alias_method ali, :teacher?
  end
end

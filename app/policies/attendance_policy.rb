class AttendancePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def destroy?
    @user.teacher
  end
end

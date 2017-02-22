class AttendancesController < ApplicationController
  before_action :authenticate_user!, :authorize_teacher!
  after_action :verify_authorized

  def destroy
    attendance = Attendance.find params[:id]
    attendance.destroy
    redirect_to attendance.student, notice: 'Record deleted'
  end

  private

  def authorize_teacher!
    authorize Attendance
  end
end

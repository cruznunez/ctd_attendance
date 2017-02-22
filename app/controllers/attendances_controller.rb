class AttendancesController < ApplicationController
  def destroy
    attendance = Attendance.find params[:id]
    attendance.destroy
    redirect_to attendance.student, notice: 'Record deleted'
  end
end

class StandUpsController < ApplicationController
  after_action :verify_authorized

  before_action :authenticate_user!, :authorize_teacher!
  before_action :set_stand_up, only: [:show, :update]

  # GET /stand_ups
  def index
    @project = Project.find params[:project_id]
    @stand_ups = @project.stand_ups
  end

  # GET /stand_ups/new
  def new
    project_id = params[:project_id]
    date = params[:date] || Date.today
    @project = Project.includes(:stand_ups, :students)
                      .order('students.first_name')
                      .find project_id
    if @project.stand_ups.select { |x| x.date == date.to_date }[0]
      redirect_to edit_project_stand_ups_path(project_id, date)
    end
  end

  # GET /stand_ups/2017-01-01/edit
  def edit
    date = params[:date]
    @project = Project.includes(:stand_ups, :students)
                      .order('students.first_name')
                      .find params[:project_id]
  end

  # POST /stand_ups
  def create
    @stand_up = StandUp.new(stand_up_params)

    if @stand_up.save
      redirect_to @stand_up, notice: 'Stand up done'
    else
      render :new
    end
  end

  # PATCH/PUT /stand_ups/1
  def update
    if @stand_up.update(stand_up_params)
      redirect_to @stand_up, notice: 'Stand up updated'
    else
      render :edit
    end
  end

  # DELETE /stand_ups/1
  def destroy
    date = params[:id].to_date
    @project = Project.find params[:project_id]
    @project.stand_ups.where(date: date).destroy_all
    redirect_to project_stand_ups_path(@project), notice: 'Stand up deleted'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stand_up
      @stand_up = StandUp.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stand_up_params
      params.require(:stand_up).permit(:project_id, :student_id, :date, :completed, :goals, :obstacles)
    end

    def authorize_teacher!
      authorize StandUp
    end
end

class ProjectsController < ApplicationController
  after_action :verify_authorized

  before_action :authenticate_user!, :authorize_teacher!
  before_action :set_project, only: [:edit, :update, :destroy]

  helper_method :sort_column

  # GET /projects
  def index
    @projects = Project.order("#{sort_column} #{sort_direction}")
  end

  # GET /projects/1
  def show
    @project = Project.includes(:students)
                      .order('students.first_name')
                      .find params[:id]
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project created'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project updated'
    else
      flash.alert @project.errors.to_a.join '. '
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project destroyed'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(
        :name, :url, :description, :add_student, :remove_student,
        stand_ups_attributes: [:id, :student_id, :date, :completed, :goals, :obstacles]
      )
    end

    def sort_column
      sort = params[:c]
      %w(name).include?(sort) ? sort : 'name'
    end

    def authorize_teacher!
      authorize Project
    end
end

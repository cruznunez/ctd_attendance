class CoursesController < ApplicationController
  before_action :authenticate_user!, :authorize_teacher!
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new course_params

    if @course.save
      redirect_to course_semesters_path(@course), notice: 'Course added'
    else
      alert_errors @course
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update course_params
      redirect_to @course, notice: 'Course updated'
    else
      alert_errors @course
      render :edit
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course deleted'
  end

  private
    def authorize_teacher!
      authorize Course
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find params[:id]
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit :name, :active
    end
end

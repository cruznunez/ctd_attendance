class SemestersController < ApplicationController
  before_action :authenticate_user!, :authorize_teacher!
  before_action :set_semester, only: [:edit, :update, :destroy, :attendance]
  before_action :set_course, only: [:index, :show]
  after_action :verify_authorized

  # GET /semesters
  def index
    @semesters = @course.semesters
  end

  # GET /semesters/1
  # def show
  #   @semester = Semester.includes(students: [:attendances])
  #                       .order('students.first_name')
  #                       .find params[:id]
  # end

  def show
    @semester = Semester.includes(:students, :attendances)
                        .order('students.first_name')
                        .find params[:id]
  end

  # GET /semesters/new
  def new
    # @course = Course.find params[:course_id]
    @semester = Semester.new course_id: params[:course_id]
  end

  # GET /semesters/1/edit
  def edit
  end

  def attendance
    date = params[:date] || Date.today
    if Attendance.where(semester_id: @semester.id, date: date).any?
      @attendances = Attendance.includes(:student)
                               .order('students.first_name')
                               .where semester_id: @semester.id, date: date
    end
  end

  # POST /semesters
  def create
    course = Course.find params[:course_id]

    @semester = course.semesters.new(semester_params)

    if @semester.save
      redirect_to [course, @semester], notice: 'Semester created'
    else
      render :new
    end
  end

  # PATCH/PUT /semesters/1
  def update
    # byebug
    if @semester.update(semester_params)
      course = Course.find params[:course_id]
      redirect_to [course, @semester], notice: 'Semester updated'
    else
      flash.alert = @semester.errors.to_a.join '. '
      render :edit
    end
  end

  # DELETE /semesters/1
  def destroy
    @semester.destroy
    redirect_to course_semesters_path, notice: 'Semester destroyed'
  end

  private
    def set_course
      @course = Course.find params[:course_id]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_semester
      @semester = Semester.find params[:id]
    end

    # Only allow a trusted parameter "white list" through.
    def semester_params
      params.require(:semester).permit(
        :name, :active, :add_student, :remove_student, students_attributes: [
          :id, attendances_attributes: [
            :id, :semester_id, :present, :date
          ]
        ]
      )
    end

    def authorize_teacher!
      authorize Semester
    end
end

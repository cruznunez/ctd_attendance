class SemestersController < ApplicationController
  before_action :authenticate_person!, :authorize_teacher!
  before_action :set_course # , only: [:index, :new, :create, :show, :edit]
  before_action :set_semester, only: [:edit, :update, :destroy]
  after_action :verify_authorized

  # GET /semesters
  def index
    if current_student
      @semesters = current_student.semesters
    elsif current_user
      @semesters = @course.semesters
    end
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
    @semester = @course.semesters.new
  end

  # GET /semesters/1/edit
  def edit
    @students = @semester.students.sort_by(&:name)
  end

  #  233ms (Views: 225.0ms | ActiveRecord: 1.0ms)
  def attendance
    date = params[:date] || Date.today
    @semester = Semester.includes(:students)
                        .order('students.first_name')
                        .find params[:id]
    @attendances = Attendance.where semester_id: @semester.id, date: date
  end

  # POST /semesters
  def create
    @semester = @course.semesters.new(semester_params)

    if @semester.save
      redirect_to [@course, @semester], notice: 'Semester added'
    else
      alert_errors @semester
      render :new
    end
  end

  # PATCH/PUT /semesters/1
  def update
    if @semester.update semester_params
      if request.xhr?
        redirect_to edit_course_semester_path @course, @semester
      else
        redirect_to [@course, @semester], notice: 'Semester updated'
      end
    else
      @students = @semester.students.sort_by(&:name)
      alert_errors @semester
      render :edit
    end
  end

  # DELETE /semesters/1
  def destroy
    @semester.destroy
    redirect_to course_semesters_path, notice: 'Semester deleted'
  end

  private
    def pundit_user
      current_person
    end

    def set_course
      @course = Course.find params[:course_id]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_semester
      @semester = @course.semesters.find params[:id]
    end

    # Only allow a trusted parameter "white list" through.
    def semester_params
      params.require(:semester).permit(
        :teacher_id, :teacher_assistant_id, :director_id,
        :name, :active, :add_student, :remove_student, student_ids: [],
        students_attributes: [
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

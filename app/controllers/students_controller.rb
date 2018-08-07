class StudentsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :update, :change_password]
  before_action :authenticate_student!, only: :change_password
  before_action :authenticate_person!, only: [:show, :update]
  before_action :set_student, only: [:edit, :update, :destroy, :change_password]
  before_action :authorize_teacher!, except: [:show, :update, :change_password]
  before_action :authorize_student!, only: [:update, :change_password]
  after_action :verify_authorized

  helper_method :sort_column

  # GET /students
  def index
    query = params[:q] || params[:term]
    @students = Student.search(query)
                       .order("#{sort_column} #{sort_direction}")

    if request.xhr?
      if request.put?
        render 'search.js' # for ajaxsearch
      elsif request.get?
        render 'search.json' # for autocomplete
      end
    end
  end

  def show
    @student = Student.includes(:projects, attendances: [semester: [:course]])
                      .order('projects.name')
                      .find params[:id]
    authorize @student
    @semesters = @student.attendances.group_by &:semester
    @date = Date.today
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to students_path, notice: 'Student added'
    else
      alert_errors @student
      render :new
    end
  end

  # PATCH/PUT /students/1
  def update
    # if the student is trying to change their password
    if request.referrer == change_password_student_url(@student)
      p 'path 1'
      if @student.update student_params
        p 'sub 1'
        # for some reason devise signs you out after you update your own info
        bypass_sign_in @student # sign in again
        redirect_to root_path, notice: 'Password changed'
      else
        p 'sub 2'
        render :edit
      end
    else
      if @student.update student_params
        redirect_to @student, notice: 'Student updated'
      else
        render :edit
      end
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student deleted'
  end

  # GET /students/1/change_password
  def change_password
  end

  private

    def authenticate_person!
      return if user_signed_in? || student_signed_in?
      message = t('devise.failure.unauthenticated')
      redirect_to new_student_session_path, alert: message
    end

    def pundit_user # overrides the pundit current_user lookup
      current_user || current_student
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(
        :image, :first_name, :last_name, :slack_name, :slack_id, :email,
        :phone_number, :notes,
        :password, :password_confirmation
      )
    end

    def sort_column
      sort = params[:c]
      %w(first_name last_name slack_name).include?(sort) ? sort : 'first_name'
    end

    def authorize_teacher!
      authorize Student
    end

    def authorize_student!
      authorize @student
    end
end

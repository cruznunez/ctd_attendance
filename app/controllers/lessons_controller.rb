class LessonsController < ApplicationController
  before_action :authenticate_person!, except: :slides_name
  before_action :set_references, except: :slides_name
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :slides]
  before_action :authorize_person!
  after_action :verify_authorized

  # GET /lessons
  def index
    if current_user
      @lessons = @semester.lessons.order(:date)
    else
      @lessons = @semester.lessons.where(visible: true).order(:date)
    end
  end

  # GET /lessons/1
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  def create
    @lesson = @semester.lessons.new lesson_params

    if @lesson.save
      redirect_to [@course, @semester, @lesson], notice: 'Lesson added'
    else
      alert_errors @lesson
      render :new
    end
  end

  # PATCH/PUT /lessons/1
  def update
    if @lesson.update lesson_params
      redirect_to [@course, @semester, @lesson], notice: 'Lesson updated'
    else
      alert_errors @lesson
      render :edit
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy
    redirect_to [@course, @semester, :lessons], notice: 'Lesson deleted'
  end

  def slides
    render layout: false
  end

  def slides_name
    @lesson = Lesson.find_by_slides_name params[:slides_name]
    render :slides, layout: false
  end

  private

  def authorize_person!
    authorize @lesson || Lesson
  end

  def pundit_user
    current_person
  end

  def set_references
    @course = Course.find params[:course_id]
    @semester = @course.semesters.find params[:semester_id]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_lesson
    @lesson = @semester.lessons.find params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def lesson_params
    params.require(:lesson).permit(
      :title, :date, :visible, :notes, :homework, :slides, :slides_name, :video, :theme, :transition
    )
  end
end

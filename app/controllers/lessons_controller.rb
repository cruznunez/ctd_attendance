class LessonsController < ApplicationController
  before_action :set_references
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = @semester.lessons
  end

  # GET /lessons/1
  # GET /lessons/1.json
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
  # POST /lessons.json
  def create
    @lesson = @semester.lessons.new lesson_params

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to [@course, @semester, @lesson], notice: 'Lesson added' }
        format.json { render :show, status: :created, location: [@course, @semester, @lesson] }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to [@course, @semester, @lesson], notice: 'Lesson updated' }
        format.json { render :show, status: :ok, location: [@course, @semester, @lesson] }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson deleted' }
      format.json { head :no_content }
    end
  end

  private

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
      params.require(:lesson).permit(:title, :date, :visible, :notes, :homework, :slides)
    end
end

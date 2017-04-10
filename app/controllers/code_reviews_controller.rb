class CodeReviewsController < ApplicationController
  before_action :set_code_review, only: [:show, :update, :destroy]
  before_action :set_project, only: [:index, :new, :create, :edit]
  helper_method :sort_column

  # GET /code_reviews
  def index
    @code_reviews = @project.code_reviews.order "#{sort_column} #{sort_direction}"
  end

  # GET /code_reviews/new
  def new
    date = params[:date] || Date.today

    # if a review for this date and project already exists, go to edit page
    if CodeReview.where(project_id: @project.id, date: date).any?
      redirect_to edit_project_code_reviews_path @project, date
    end

    @code_review = CodeReview.new project_id: @project.id
    set_previous_reviews date
  end

  # GET /projects/1/code_reviews/2017-01-01/edit
  def edit
    # lets load the 3 most recent code reviews since the date provided
    date = params[:date]
    # @code_review = CodeReview.where(project_id: @project.id, date: date).first
    @code_review = @project.code_reviews.where(date: date).first
    set_previous_reviews date
  end

  # GET /projects/1/code_reviews/form
  # GET /projects/1/code_reviews/form?date=2017-01-01
  # this action combines the new and edit actions into one because why not
  def form
    date = params[:date] || Date.today
    @project = Project.find params[:project_id]
    @code_review = CodeReview.where(project_id: @project.id, date: date)
                             .first_or_initialize
    set_previous_reviews date
  end

  # POST /code_reviews
  def create
    @code_review = @project.code_reviews.new code_review_params

    if @code_review.save
      redirect_to project_code_reviews_path, notice: 'Code review created'
    else
      alert_errors @code_review
      set_previous_reviews(@code_review.date)
      render :new
    end
  end

  # PATCH/PUT /code_reviews/1
  def update
    if @code_review.update(code_review_params)
      redirect_to project_code_reviews_path, notice: 'Code review updated'
    else
      render :edit
    end
  end

  # DELETE /code_reviews/1
  def destroy
    @code_review.destroy
    redirect_to code_reviews_url, notice: 'Code review destroyed'
  end

  # GET /preview_review
  def preview
    @id = "#{params[:id]}_preview"
    @text = params[:text]
  end

  private
    def alert_errors(resource)
      flash.alert = resource.errors.to_a.join '. '
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_code_review
      @code_review = CodeReview.find params[:id]
    end

    def set_project
      @project = Project.find params[:project_id]
    end

    def set_previous_reviews(date)
      @previous_reviews = CodeReview.where('project_id = ? AND date < ?', @project.id, date)
                                    .limit(2)
                                    .order(date: :desc)
    end

    # Only allow a trusted parameter "white list" through.
    def code_review_params
      params.require(:code_review).permit(
        :date, :loc, :smells, :tests, :failures, :coverage, :comments, :notes
      )
    end

    def sort_column
      sort = params[:c]
      %w(date loc smells tests failures coverage).include?(sort) ? sort : 'date'
    end
end

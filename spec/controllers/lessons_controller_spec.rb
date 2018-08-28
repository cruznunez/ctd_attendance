require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  let(:valid_attributes) { attributes_for :lesson }
  let(:invalid_attributes) { attributes_for :lesson, title: nil }

  before do
    @course = create :course
    @semester = create :semester
    @teacher = create :user, teacher: true
    sign_in @teacher
  end

  describe "GET #index" do
    before do
      @lesson = create :lesson
    end

    it "returns a success response" do
      get :index, params: { course_id: @course, semester_id: @semester, id: @lesson }
      response.should be_success
    end
  end

  describe "GET #show" do
    before do
      @lesson = create :lesson
    end

    it "returns a success response" do
      get :show, params: { course_id: @course, semester_id: @semester, id: @lesson }
      response.should be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { course_id: @course, semester_id: @semester }
      response.should be_success
    end
  end

  describe "GET #edit" do
    before do
      @lesson = create :lesson
    end

    it "returns a success response" do
      get :edit, params: { course_id: @course, semester_id: @semester, id: @lesson }
      response.should be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Lesson" do
        expect do
          post :create, params: { course_id: @course, semester_id: @semester, lesson: valid_attributes }
        end.to change(Lesson, :count).by 1
      end

      it "redirects to the created lesson" do
        post :create, params: { course_id: @course, semester_id: @semester, lesson: valid_attributes }
        response.should redirect_to [@course, @semester, Lesson.last]
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        post :create, params: { course_id: @course, semester_id: @semester, lesson: invalid_attributes }
        flash.alert.should eq "Title can't be blank"
        flash.notice.should eq nil
        response.should be_success
      end
    end
  end

  describe "PUT #update" do
    before do
      @lesson = create :lesson
    end

    context "with valid params" do
      let(:new_attributes) {
        attributes_for :lesson, title: 'new'
      }

      it "updates the requested lesson" do
        put :update, params: { course_id: @course, semester_id: @semester, id: @lesson, lesson: new_attributes }
        @lesson.title.should eq 'MyString'
        @lesson.reload
        @lesson.title.should eq 'new'
      end

      it "redirects to the lesson" do
        put :update, params: { course_id: @course, semester_id: @semester, id: @lesson, lesson: new_attributes }
        response.should redirect_to [@course, @semester, @lesson]
      end
    end

    context "with invalid params" do
      it "returns a success response" do
        put :update, params: { course_id: @course, semester_id: @semester, id: @lesson, lesson: invalid_attributes }
        response.should be_success
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @lesson = create :lesson
    end

    it "destroys the requested lesson" do
      expect do
        delete :destroy, params: { course_id: @course, semester_id: @semester, id: @lesson }
      end.to change(Lesson, :count).by(-1)
    end

    it "redirects to the lessons list" do
      delete :destroy, params: { course_id: @course, semester_id: @semester, id: @lesson }
      response.should redirect_to [@course, @semester, :lessons]
    end
  end
end

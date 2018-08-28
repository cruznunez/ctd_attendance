require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      lesson = Lesson.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      lesson = Lesson.create! valid_attributes
      get :show, params: {id: lesson.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      lesson = Lesson.create! valid_attributes
      get :edit, params: {id: lesson.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Lesson" do
        expect {
          post :create, params: {lesson: valid_attributes}
        }.to change(Lesson, :count).by(1)
      end

      it "redirects to the created lesson" do
        post :create, params: {lesson: valid_attributes}
        expect(response).to redirect_to(Lesson.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {lesson: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested lesson" do
        lesson = Lesson.create! valid_attributes
        put :update, params: {id: lesson.to_param, lesson: new_attributes}
        lesson.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the lesson" do
        lesson = Lesson.create! valid_attributes
        put :update, params: {id: lesson.to_param, lesson: valid_attributes}
        expect(response).to redirect_to(lesson)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        lesson = Lesson.create! valid_attributes
        put :update, params: {id: lesson.to_param, lesson: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested lesson" do
      lesson = Lesson.create! valid_attributes
      expect {
        delete :destroy, params: {id: lesson.to_param}
      }.to change(Lesson, :count).by(-1)
    end

    it "redirects to the lessons list" do
      lesson = Lesson.create! valid_attributes
      delete :destroy, params: {id: lesson.to_param}
      expect(response).to redirect_to(lessons_url)
    end
  end
end

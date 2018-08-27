require "rails_helper"

RSpec.describe LessonsController, type: :routing do
  let(:hash) { { course_id: '1', semester_id: '2' } }
  let(:hashid) { hash.merge(id: '3') }

  it "routes to #index" do
    get("/courses/1/semesters/2/lessons").should route_to "lessons#index", hash
  end

  it "routes to #new" do
    get("/courses/1/semesters/2/lessons/new").should route_to "lessons#new", hash
  end

  it "routes to #show" do
    get("/courses/1/semesters/2/lessons/3").should route_to "lessons#show", hashid
  end

  it "routes to #edit" do
    get("/courses/1/semesters/2/lessons/3/edit").should route_to "lessons#edit", hashid
  end

  it "routes to #create" do
    post("/courses/1/semesters/2/lessons").should route_to "lessons#create", hash
  end

  it "routes to #update via PUT" do
    put("/courses/1/semesters/2/lessons/3").should route_to "lessons#update", hashid
  end

  it "routes to #update via PATCH" do
    patch("/courses/1/semesters/2/lessons/3").should route_to "lessons#update", hashid
  end

  it "routes to #destroy" do
    delete("/courses/1/semesters/2/lessons/3").should route_to "lessons#destroy", hashid
  end

  it 'routes to #slides' do
    get("/courses/1/semesters/2/lessons/3/slides").should route_to "lessons#slides", hashid
  end
end

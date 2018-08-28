require 'rails_helper'

RSpec.describe "lessons/edit", type: :view do
  before do
    @course = create :course
    @semester = create :semester
    @lesson = assign :lesson, create(:lesson)
  end

  it "renders the edit lesson form" do
    render

    assert_select "form[action=?][method=?]", course_semester_lesson_path(@course, @semester, @lesson), "post" do

      assert_select "input#lesson_title[name=?]", "lesson[title]"

      assert_select "input#lesson_visible[name=?]", "lesson[visible]"

      assert_select "textarea#lesson_notes[name=?]", "lesson[notes]"

      assert_select "textarea#lesson_homework[name=?]", "lesson[homework]"

      assert_select "textarea#lesson_slides[name=?]", "lesson[slides]"
    end
  end
end

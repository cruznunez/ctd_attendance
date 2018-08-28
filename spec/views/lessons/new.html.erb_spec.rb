require 'rails_helper'

RSpec.describe "lessons/new", type: :view do
  before do
    @course = assign :course, create(:course)
    @semester = assign :semester, create(:semester)
    @lesson = assign :lesson, build(:lesson)
  end

  it "renders new lesson form" do
    render

    assert_select "form[action=?][method=?]", course_semester_lessons_path(@course, @semester), "post" do
      assert_select "input#lesson_title[name=?]", "lesson[title]"

      assert_select "input#lesson_visible[name=?]", "lesson[visible]"

      assert_select "textarea#lesson_notes[name=?]", "lesson[notes]"

      assert_select "textarea#lesson_homework[name=?]", "lesson[homework]"

      assert_select "textarea#lesson_slides[name=?]", "lesson[slides]"
    end
  end
end

require 'rails_helper'

RSpec.describe "lessons/new", type: :view do
  before(:each) do
    assign(:lesson, Lesson.new(
      :title => "MyString",
      :visible => false,
      :notes => "MyText",
      :homework => "MyText",
      :slides => "MyText"
    ))
  end

  it "renders new lesson form" do
    render

    assert_select "form[action=?][method=?]", lessons_path, "post" do

      assert_select "input#lesson_title[name=?]", "lesson[title]"

      assert_select "input#lesson_visible[name=?]", "lesson[visible]"

      assert_select "textarea#lesson_notes[name=?]", "lesson[notes]"

      assert_select "textarea#lesson_homework[name=?]", "lesson[homework]"

      assert_select "textarea#lesson_slides[name=?]", "lesson[slides]"
    end
  end
end

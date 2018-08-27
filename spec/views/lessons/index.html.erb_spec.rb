require 'rails_helper'

RSpec.describe "lessons/index", type: :view do
  before(:each) do
    assign(:lessons, [
      Lesson.create!(
        :title => "Title",
        :visible => false,
        :notes => "MyText",
        :homework => "MyText",
        :slides => "MyText"
      ),
      Lesson.create!(
        :title => "Title",
        :visible => false,
        :notes => "MyText",
        :homework => "MyText",
        :slides => "MyText"
      )
    ])
  end

  it "renders a list of lessons" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

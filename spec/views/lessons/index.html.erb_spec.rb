require 'rails_helper'
include Pundit

RSpec.describe "lessons/index", type: :view do
  before do
    @course = create :course
    @semester = create :semester
    l1 = create :lesson
    l2 = create :lesson

    assign :lessons, [l1, l2]
  end

  it "renders a list of lessons" do
    render

    within '.card' do
      page.should match "#{Date.today.strftime('%-m/%-d')} - MyString"
      page.should match "Slides"
    end
  end
end

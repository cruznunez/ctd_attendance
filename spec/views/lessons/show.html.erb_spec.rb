require 'rails_helper'
include Pundit

RSpec.describe "lessons/show", type: :view do
  before do
    @course = create :course
    @semester = create :semester
    @lesson = assign :lesson, create(:lesson)
    @teacher = create :user
    sign_in @teacher
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end

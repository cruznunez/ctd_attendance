FactoryBot.define do
  factory :lesson do
    semester { Semester.first }
    title "MyString"
    date "2018-08-27"
    visible false
    notes "MyText"
    homework "MyText"
    slides "MyText"
  end
end

# frozen_string_literal: true
FactoryBot.define do
  factory :attendance do
    semester { Semester.first }
    student { Student.first }
    date { Date.today }
  end
end

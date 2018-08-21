# frozen_string_literal: true
FactoryBot.define do
  factory :semester do
    course { Course.first }
    name 'Fall 2017'
  end
end

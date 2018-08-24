# frozen_string_literal: true
FactoryBot.define do
  factory :student do
    first_name 'John'
    last_name 'Doe'
    email 'a@student.com'

    trait 2 do
      email 'b@student.com'
    end

    trait 3 do
      email 'c@student.com'
    end
  end
end

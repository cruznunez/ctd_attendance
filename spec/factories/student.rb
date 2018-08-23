# frozen_string_literal: true
FactoryBot.define do
  factory :student do
    first_name 'John'
    last_name 'Doe'
    email 'a@a.a'

    trait 2 do
      email 'b@b.b'
    end

    trait 3 do
      email 'c@c.c'
    end
  end
end

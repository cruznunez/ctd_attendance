# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    email 'a@a.a'
    password 'password'

    trait 2 do
      email 'b@b.b'
    end

    trait 3 do
      email 'c@c.c'
    end
  end
end

# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    email 'a@user.com'
    password 'password'

    trait 2 do
      email 'b@user.com'
    end

    trait 3 do
      email 'c@user.com'
    end
  end
end

class Course < ApplicationRecord
  has_many :semesters
  validates :name, presence: true
end

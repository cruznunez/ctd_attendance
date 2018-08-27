class Lesson < ApplicationRecord
  belongs_to :semester

  validates_presence_of :semester
end

class Lesson < ApplicationRecord
  belongs_to :semester

  validates :slides, uniqueness: true, allow_nil: true

  validates_presence_of :semester, :title
end

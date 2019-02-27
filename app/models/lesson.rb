class Lesson < ApplicationRecord
  belongs_to :semester

  validates :slides_name, uniqueness: true, allow_nil: true

  validates_presence_of :semester, :title
end

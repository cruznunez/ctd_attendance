class CodeReview < ApplicationRecord
  belongs_to :project
  validates_presence_of :date, :loc, :smells, :tests, :failures, :coverage
end

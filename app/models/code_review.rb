class CodeReview < ApplicationRecord
  belongs_to :project
  validates_presence_of :date, :loc, :smells, :tests, :failures, :coverage
  validates :coverage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :loc, numericality: { greater_than_or_equal_to: 0 }
  validates :smells, numericality: { greater_than_or_equal_to: 0 }
  validates :tests, numericality: { greater_than_or_equal_to: 0 }
  validates :failures, numericality: { greater_than_or_equal_to: 0 }

  def edit_path
    "/projects/#{project_id}/code_reviews/form?date=#{date}"
  end
end

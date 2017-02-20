class Student < ApplicationRecord
  has_and_belongs_to_many :semesters
  has_many :attendances, dependent: :destroy
  accepts_nested_attributes_for :attendances

  def name
    "#{first_name} #{last_name}"
  end
end

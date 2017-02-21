class Student < ApplicationRecord
  has_and_belongs_to_many :semesters
  has_many :attendances, dependent: :destroy
  accepts_nested_attributes_for :attendances

  has_attached_file :image, default_url: '/plus.png', styles: { thumb: '90x90#' }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def name
    "#{first_name} #{last_name}"
  end
end

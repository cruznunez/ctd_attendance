class Student < ApplicationRecord
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :semesters
  has_many :attendances, dependent: :destroy
  has_many :stand_ups, dependent: :destroy
  accepts_nested_attributes_for :attendances

  has_attached_file :image, default_url: '/plus.png', styles: { thumb: '90x90#' }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def name
    "#{first_name} #{last_name}"
  end

  def self.search(query)
    return all unless query.present?
    size = query.split.size

    # case insensitive operator differs in production vs development due to
    # diffrent databases in heroku dev or test
    operator = Rails.env.production? ? 'ILIKE' : 'LIKE'

    columns = %w(first_name last_name)

    # Wrap terms in %'s to allow wildcards
    array_of_terms = (query.split * columns.size).sort.map { |term| "%#{term}%" }
    search_phrase = columns.map { |x| "#{x} #{operator} ?" }.join(' OR ')

    where(
      [
        ([search_phrase] * size).join(' AND ')
      ] + array_of_terms
    )
  end
end

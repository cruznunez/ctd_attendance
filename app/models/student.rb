class Student < ApplicationRecord
  before_save :update_from_slack, if: :slack_name_changed?
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :semesters
  has_many :attendances, dependent: :destroy
  has_many :stand_ups, dependent: :destroy
  accepts_nested_attributes_for :attendances

  has_attached_file :image, default_url: '/plus.png', styles: { thumb: '90x90#' }

  # nilify_blanks only: [:slack_id], types: nil
  # nilify_blanks only: %w(first_name last_name slack_name notes image_file_name image_content_type email phone_number slack_id)

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def name
    "#{first_name} #{last_name}"
  end

  def slack_info
    Slack.new.users.find { |x| x['name'] == slack_name }.to_o
  end

  # monkey patch to get the slack_id column to get nilified too
  def self.content_columns
    super << columns.find { |x| x.name == 'slack_id' }
  end

  def self.nilify_blanks_columns
    super << 'slack_id'
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

  private

  def update_from_slack
    return unless slack_name
    slack_data = slack_info.id
    img_url = slack_info.profile.image_original
    self.slack_id = slack_data
    self.image = URI.parse img_url if img_url # && image.url == '/plus.png'
  rescue NoMethodError
    self.slack_id = nil
  end
end

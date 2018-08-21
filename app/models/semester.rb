class Semester < ApplicationRecord
  belongs_to :course
  belongs_to :director, class_name: :User
  belongs_to :teacher, class_name: :User
  belongs_to :teacher_assistant, class_name: :User

  has_and_belongs_to_many :students

  has_many :attendances, dependent: :destroy

  accepts_nested_attributes_for :students

  validates :name, presence: true

  # add student to students via student_id sent through params
  def add_student=(student_id)
    return if student_id.blank? || students.exists?(student_id)
    students << Student.find(student_id)
  end

  def remove_student
    students.sort_by(&:name).map { |x| [x.name, x.id] }
  end

  def remove_student=(student_id)
    return unless student_id.present?
    students.destroy Student.find student_id
  end
end

class Semester < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :students
  accepts_nested_attributes_for :students
  has_many :attendances

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

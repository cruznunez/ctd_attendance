class Semester < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :students
  accepts_nested_attributes_for :students

  # list students not added yet
  def add_student
    (Student.all - students).pluck :first_name, :id
  end

  # add student to students via student_id sent through params
  def add_student=(student_id)
    return unless student_id.present?
    students << Student.find(student_id)
  end

  def remove_student
    students.pluck :first_name, :id
  end

  def remove_student=(student_id)
    return unless student_id.present?
    students.destroy Student.find student_id
  end
end

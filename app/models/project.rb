class Project < ApplicationRecord
  has_and_belongs_to_many :students
  has_many :code_reviews
  has_many :stand_ups
  accepts_nested_attributes_for :stand_ups, reject_if: :reject_stand_up?
  validates_presence_of :name

  # list students not added yet
  def add_student
    (Student.order(:first_name).all - students).pluck:first_name, :id
  end

  # add student to students via student_id sent through params
  def add_student=(student_id)
    return unless student_id.present?
    students << Student.find(student_id)
  end

  def remove_student
    students.order(:first_name).pluck :first_name, :id
  end

  def remove_student=(student_id)
    return unless student_id.present?
    students.destroy Student.find student_id
  end

  private

  def reject_stand_up?(a)
    [a[:completed], a[:goals], a[:obstacles]].all? &:blank?
  end
end

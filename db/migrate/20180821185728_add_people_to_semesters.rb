class AddPeopleToSemesters < ActiveRecord::Migration[5.0]
  def change
    add_column :semesters, :teacher_id, :integer
    add_column :semesters, :teacher_assistant_id, :integer
    add_column :semesters, :director_id, :integer
  end
end

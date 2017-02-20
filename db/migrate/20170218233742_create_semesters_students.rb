class CreateSemestersStudents < ActiveRecord::Migration[5.0]
  def change
    create_join_table :semesters, :students  end
end

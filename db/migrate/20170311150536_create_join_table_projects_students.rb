class CreateJoinTableProjectsStudents < ActiveRecord::Migration[5.0]
  def change
    create_join_table :projects, :students do |t|
      t.index :project_id
      t.index :student_id
    end
  end
end

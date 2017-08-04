class AddSlackIdToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :slack_id, :string
  end
end

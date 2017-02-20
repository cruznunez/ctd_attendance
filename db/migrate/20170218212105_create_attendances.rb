class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :semester, foreign_key: true
      t.references :student, foreign_key: true

      t.date :date

      t.boolean :present
    end
  end
end

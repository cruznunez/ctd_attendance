class CreateStandUps < ActiveRecord::Migration[5.0]
  def change
    create_table :stand_ups do |t|
      t.references :project, foreign_key: true
      t.references :student, foreign_key: true

      t.date :date

      t.text :completed
      t.text :goals
      t.text :obstacles
    end
  end
end

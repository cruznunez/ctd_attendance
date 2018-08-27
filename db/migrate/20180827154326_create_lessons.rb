class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.references :semester

      t.string :title
      t.date :date
      t.boolean :visible
      t.text :notes
      t.text :homework
      t.text :slides

      t.timestamps
    end
  end
end

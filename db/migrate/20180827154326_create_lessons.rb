class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.references :semester

      t.date :date
      t.string :title
      t.boolean :visible
      t.text :notes
      t.text :homework
      t.text :slides
      t.string :video_url

      t.timestamps
    end
  end
end

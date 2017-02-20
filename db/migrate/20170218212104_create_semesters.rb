class CreateSemesters < ActiveRecord::Migration[5.0]
  def change
    create_table :semesters do |t|
      t.references :course, foreign_key: true

      t.string :name

      t.boolean :active
    end
  end
end

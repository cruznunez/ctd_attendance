class CreateCodeReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :code_reviews do |t|
      t.references :project, foreign_key: true

      t.date :date

      t.integer :loc
      t.integer :smells
      t.integer :tests
      t.integer :failures
      t.float :coverage
      t.text :comments
      t.text :notes
    end
  end
end

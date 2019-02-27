class AddSlidesNameToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :slides_name, :string
    add_index :lessons, :slides_name
  end
end

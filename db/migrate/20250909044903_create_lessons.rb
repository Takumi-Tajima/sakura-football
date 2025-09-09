class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :participation_fee, null: false
      t.boolean :is_published, null: false, default: false

      t.timestamps
    end
  end
end

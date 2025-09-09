class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.integer :participant_count, null: false
      t.integer :participation_fee, null: false
      t.integer :court_fee, null: false
      t.integer :total_fee, null: false
      t.string :session_name, null: false
      t.datetime :session_at, null: false

      t.timestamps
    end
  end
end

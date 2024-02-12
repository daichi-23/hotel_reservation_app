class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :person_num, null: false
      t.bigint :user_id
      t.bigint :room_id

      t.timestamps
    end
  end
end

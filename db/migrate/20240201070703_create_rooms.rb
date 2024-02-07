class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :room_name, null: false
      t.string :room_image
      t.text :room_introduction, null: false
      t.integer :price, null:false
      t.string :address, null:false
      t.bigint :user_id

      t.timestamps
    end
  end
end

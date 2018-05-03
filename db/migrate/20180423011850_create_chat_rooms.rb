class CreateChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.boolean :is_reply, default: true

      t.timestamps
    end
  end
end

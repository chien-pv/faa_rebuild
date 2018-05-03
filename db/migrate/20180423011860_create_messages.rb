class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :chat_room, index: true, foreign_key: true
      t.text :message
      t.boolean :is_supporter, default: false

      t.timestamps
    end
  end
end

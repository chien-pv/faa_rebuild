class Message < ApplicationRecord
  belongs_to :chat_room

  validates :message, presence: true

  after_create :send_message, :sent_message_auto

  scope :messages_in_room, ->room_id{where chat_room_id: room_id}
  scope :order_asc, ->{order created_at: :asc}
  scope :supporter, ->{where is_supporter: true}

  private

  def send_message
    unless self.is_supporter
      room = self.chat_room
      room.update_attribute :is_reply, false
    end
    SendMessageJob.perform_now self
  end

  def sent_message_auto
    if self.chat_room.messages.count == Settings.chatbot.postion_message
      ChatbotJob.perform_now(self)
    end
  end
end

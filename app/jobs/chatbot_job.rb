class ChatbotJob < ApplicationJob
  queue_as :message

  def perform message
    Message.create chat_room_id: message.chat_room.id,
      message: I18n.t("layouts.chat_body.admin_busy"), is_supporter: true
  end
end

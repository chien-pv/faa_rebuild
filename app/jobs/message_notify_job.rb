class MessageNotifyJob < ApplicationJob
  queue_as :notify

  include ResponseMessageNotify

  def perform
    chatrooms = ChatRoom.not_reply_yet.newest.pluck(:id)
    messages = response_room_and_last_message
    ActionCable.server.broadcast "admin_message_notify", chat_rooms: chatrooms, messages: messages
  end
end

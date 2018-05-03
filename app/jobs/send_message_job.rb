class SendMessageJob < ApplicationJob
  queue_as :message

  def perform message
    ActionCable.server.broadcast "chat_rooms_#{message.chat_room.id}_channel",
      message: render_message(message), message_json: message.to_json
  end

  private

  def render_message message
    ApplicationController.renderer.render partial: "messages/message",
      locals: {message: message}
  end
end

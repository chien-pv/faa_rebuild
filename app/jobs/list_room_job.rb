class ListRoomJob < ApplicationJob
  queue_as :room

  def perform room
    ActionCable.server.broadcast "chat_room_list_channel", room: room
  end
end

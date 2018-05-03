module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      # current_admin = find_current_admin
      # if current_admin.present?
      #   logger.add_tags "ActionCable", current_admin.email
      # else
      #   find_verified_room
      #   logger.add_tags "ActionCable", @room.email
      # end
    end

    protected
    def find_verified_room
      @room = ChatRoom.find_by id: cookies[:room_id]
      return if @room
      reject_unauthorized_connection
    end

    def find_current_admin
      Admin.find_by id: cookies.signed[:admin_id]
    end
  end
end

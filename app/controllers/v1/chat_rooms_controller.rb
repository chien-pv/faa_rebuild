class V1::ChatRoomsController < V1::ApiController
  before_action :load_room, only: [:show, :update]

  def index
    chat_rooms = ChatRoom.newest
    response_success nil, {chat_rooms: chat_rooms}
  end

  def show
    messages = @chat_room.messages.order_asc
    response_success nil, {messages: messages, chat_room: @chat_room}
  end

  private

  def load_room
    @chat_room = ChatRoom.find_by id: params[:id]
    return if @chat_room
    response_not_found t(".not_found"), nil
  end
end

class V1::MessagesController < V1::ApiController
  before_action :load_chat_room, only: :create

  def create
    message = @chat_room.messages.new message_params
    ActiveRecord::Base.transaction do
      message.save!
      @chat_room.update_attributes! is_reply: true
      response_success nil, {message: message}
    end
  rescue
    response_error t(".save_failed"), message.errors.full_messages
  end

  private

  def message_params
    params.permit :is_supporter, :message
  end

  def load_chat_room
    @chat_room = ChatRoom.find_by id: params[:chat_room_id]
    return if @chat_room
    response_not_found t(".not_found_room"), nil
  end
end

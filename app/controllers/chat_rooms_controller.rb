class ChatRoomsController < ApplicationController
  before_action :load_room, only: :create

  def create
    return if @room
    @room = ChatRoom.new chat_room_params
    if @room.save
      set_cookie_and_load_messages
    elsif @room.errors.blank?
      flash[:danger] = t ".save_errors"
    end
  end

  def show
    room = ChatRoom.find_by id: params[:id]
    html = render_to_string partial: "form", locals: {chat_room: ChatRoom.new}
    respond_to do |format|
      format.js {render json: {html: html, room: room}}
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit :name, :email, :phone
  end

  def load_room
    @room = ChatRoom.find_by email: params[:chat_room][:email]
    set_cookie_and_load_messages if @room
  end

  def set_cookie_and_load_messages
    cookies[:room_id] = {value: @room.id, expires: Settings.expires_cookie.day.from_now}
    load_messages
  end
end

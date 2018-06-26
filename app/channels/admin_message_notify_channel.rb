class AdminMessageNotifyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "admin_message_notify"
  end

  def unsubscribed
  end
end

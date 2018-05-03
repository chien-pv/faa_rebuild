module MessagesHelper
  def class_button_disable boolean
    if boolean
      "disable-btn"
    end
  end

  def title_button_send disable
    if disable
      t ".please_fill_information"
    else
      t ".click_to_send"
    end
  end

  def is_blank_cookies_room?
    cookies[:room_id].blank?
  end
end

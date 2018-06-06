module ResponseMessageNotify
  def response_room_and_last_message
    sql = <<~QUERYLASTMESSAGE
      SELECT  chat.name, chat.email, chat.id as room_id, message.message,
        message.is_supporter, message.created_at as time
      FROM  chat_rooms AS chat JOIN
      ( SELECT  m1.message , m1.id, m1.chat_room_id, m1.is_supporter, m1.created_at
            FROM  messages as m1 left join messages as m2 on m2.chat_room_id = m1.chat_room_id and  m2.id > m1.id
            where m2.id is null order by m1.chat_room_id
      ) AS message  on chat.id = message.chat_room_id  where chat.is_reply = false
    QUERYLASTMESSAGE
    ActiveRecord::Base.connection.execute(sql)
  end
end

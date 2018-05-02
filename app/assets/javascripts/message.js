$(document).ready(function(){
  $('#new_message').submit(function(event){
    var chat_room_id = $.cookie('chat_room_id');
    event.preventDefault();
    var name = $('#chat_room_name').val();
    var email = $('#chat_room_email').val();
    var phone = $('#chat_room_phone').val();
    var data = {chat_room: {name: name, email: email, phone: phone}};
    $.ajax({
      url: '/chat_rooms',
      method: 'POST',
      data: data,
    });
  });
});

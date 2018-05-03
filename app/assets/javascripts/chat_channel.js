$(document).ready(function(){
  var chat_room_id = $.cookie('room_id');
  if (typeof chat_room_id != 'undefined'){
    App.chat_room = App.cable.subscriptions.create ({
      channel: 'ChatRoomsChannel',
      chat_room_id: chat_room_id
    },
    {
      connected: function(){
        $('.chat-body').animate({scrollTop: $('#list-messages').height()}, 'slow');
      },

      disconnected: function(){
        if(typeof($.cookie('room_id')) != 'undefined'){
          var check = false;
          $.ajax(
          {
            url: '/chat_rooms/' + chat_room_id,
            type: 'GET',
            dataType: 'json',
            success: function(res) {
              if (res.room == null){
                $.removeCookie('room_id', {path: '/'});
                $('.chat-body').html(res.html);
                App.cable.subscriptions.remove(App.chat_room);
              }
            }
          });
        }
      },

      received: function(data){
        $('#list-messages').append(data.message);
        $('.chat-body').animate({scrollTop: $('#list-messages').height()}, 'slow');
      },

      send_message: function(message){
        this.perform('send_message', {message: message, chat_room_id: chat_room_id});
      }
    });
  }

  $(document).on('submit', '#new_message', function(event){
    event.preventDefault();
    if ($('.chat-field').val().length > 0 && typeof(App.chat_room) != 'undefined') {
      App.chat_room.send_message($('.chat-field').val());
      $('.chat-field').val('');
    }
  })
})

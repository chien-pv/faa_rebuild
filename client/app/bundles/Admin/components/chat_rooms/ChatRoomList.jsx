import React from 'react';
import ChatRoom from './ChatRoom';
import axios from 'axios';
import {Link} from 'react-router-dom';
import {FormattedMessage, injectIntl, intlShape} from 'react-intl';
import {defaultMessages} from '../../../../libs/i18n/default';
import ReactOnRails from 'react-on-rails';

class ChatRoomList extends React.Component {

  constructor(props, _railsContext) {
    super(props);
    this.state = {
      chat_rooms: []
    };
  }

  componentDidMount() {
    this.getRoomListData();
    if(typeof(App.room_list) === 'undefined'){
      App.room_list = App.cable.subscriptions.create({
        channel: 'ChatRoomListChannel',
      },
      {
        connected: () => {
        },
        disconnected: () => {
        },
        received: (data) => {
          this.getRoomListData();
        },
      });
    }
  }

  componentWillReceiveProps(){
    const searchParams = new URLSearchParams(window.location.search);
    if (searchParams.has('reload')){
      window.location.replace('/admin/chat_rooms/0');
    }
  }

  getRoomListData() {
    axios.get('/v1/chat_rooms.json', {
      headers: {'Authorization': this.props.authenticity_token},
    })
    .then(response => {
      const {chat_rooms} = response.data.content;
      this.setState({chat_rooms});

    })
    .catch(error => {
      console.log(error);
    });
  }

  render() {
    const {formatMessage} = this.props.intl;

    return (
      <div className="col-md-2 col-sm-3 col-xs-12 pad-0">
        <ul className="nav custom-nav">
          {
            this.state.chat_rooms.map(chat_room => (
              <ChatRoom {...chat_room} key={chat_room.id} authenticity_token={this.props.authenticity_token} room_id={this.props.room_id}/>
            ))
          }
        </ul>
      </div>
    );
  }
}

export default injectIntl(ChatRoomList);

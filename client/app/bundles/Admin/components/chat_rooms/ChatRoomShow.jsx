import React from 'react';
import axios from 'axios';
import MessageNew from '../messages/MessageNew';
import Message from '../messages/Message';
import ChatRoom from './ChatRoom';
import ChatRoomList from './ChatRoomList';
import {Link} from 'react-router-dom';
import {FormattedMessage, injectIntl, intlShape} from 'react-intl';
import {defaultMessages} from '../../../../libs/i18n/default';
import ReactOnRails from 'react-on-rails';

class ChatRoomShow extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      messages: [],
      chat_room: "",
    };
  }

  componentWillReceiveProps(nextProps) {
    this.getDataMessages(nextProps.match.params.id);
    this.createSocket(nextProps.match.params.id);
  }

  componentDidMount() {
    this.getDataMessages(this.props.match.params.id);
    this.createSocket(this.props.match.params.id);
  }

  getDataMessages(id) {
    axios.get(`/v1/chat_rooms/${id}.json`, {
      headers: {'Authorization': this.props.authenticity_token},
    })
    .then(response => {
      const {messages, chat_room} = response.data.content;
      this.setState({messages, chat_room});
    })
    .catch(error => {
      console.log(error);
    });
  }

  updateDataState(message){
    this.state.messages.push(JSON.parse(message));
    this.setState({messages: this.state.messages});
  }

  createSocket(id) {
    if (App.chat_room) {
      App.chat_room.unsubscribe();
      App.cable.subscriptions.remove(App.chat_room);
    }
    App.chat_room = App.cable.subscriptions.create({
      channel: 'ChatRoomsChannel',
      chat_room_id: id,
    },
    {
      connected: () => {
      },
      disconnected: () => {
      },
      received: (data) => {
        this.updateDataState(data.message_json);
      },
    });
  }

  componentDidUpdate() {
    $('.list-message-scroll').animate({scrollTop: $('.list-messages').height()}, 'fast');
  }

  render() {
    const {formatMessage} = this.props.intl;
    return (
      <div className="row">
        <ChatRoomList authenticity_token={this.props.authenticity_token} room_id={this.state.chat_room.id}/>
        <div className="col-md-6 col-sm-8 col-xs-12">
        <div className="room-header">
          <p>{this.state.chat_room.email} | {this.state.chat_room.name} | {this.state.chat_room.phone}</p>
        </div>
          <div className="list-message-scroll">
            <div className="list-messages">
            {
              this.state.messages.map(message => (
                <Message {...message} key={message.id} authenticity_token={this.props.authenticity_token}/>
              ))
            }
            </div>
          </div>
          <MessageNew intl={this.props.intl} authenticity_token={this.props.authenticity_token} id={this.state.chat_room.id}/>
        </div>
      </div>
    );
  }
}

export default injectIntl(ChatRoomShow);

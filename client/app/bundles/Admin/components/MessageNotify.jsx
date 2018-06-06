import React from 'react';
import axios from 'axios';
import ReactOnRails from 'react-on-rails';
import {Link} from 'react-router-dom';
import {FormattedMessage, injectIntl, intlShape} from 'react-intl';
import {defaultMessages} from '../../../libs/i18n/default';

class MessageNotify extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = {count_rooms: 0, messages: []};
  }

  componentDidMount() {
    App.room_list = App.cable.subscriptions.create({
      channel: 'AdminMessageNotifyChannel',
    },
    {
      connected: () => {
      },
      disconnected: () => {
      },
      received: (data) => {
        this.setState({count_rooms: data.chat_rooms.length});
        this.setState({messages: data.messages});
        this.setState({
          listMessages: this.state.messages.map(
            (message, index) => <Item key={message.room_id} name={message.name}
              time={message.time} message={message.message} room_id={message.room_id}/>
          )
        })
      },
    });

    axios.get('/v1/chat_rooms/not_reply_yet.json', {
      headers: {'Authorization': this.props.authenticity_token}
    })
    .then(response => {
      let messages = response.data.content.chat_rooms
      let count_rooms = messages.length;
      this.setState({count_rooms: count_rooms});
      this.setState({messages: messages});
      this.setState({
        listMessages: this.state.messages.map(
          (message, index) => <Item key={message.room_id} name={message.name} time={message.time} message={message.message} room_id={message.room_id}/>
        )
      })
    })
    .catch(error => {
      console.log(error);
    });
  }

  render() {
    const {formatMessage} = this.props.intl;

    return (
      <ul className="navbar-nav navbar-right nav top-nav">
        <li className="nav-item dropdown">
          <Link to="" className="nav-link dropdown-toggle mr-lg-2" id="messagesDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" >
            <i className="fa fa-fw fa-envelope"></i>
            <span className="d-lg-none">{formatMessage(defaultMessages.adminMessagesTitle)}
              {this.state.count_rooms > 0 &&
                <span className="badge badge-pill badge-primary">{this.state.count_rooms} {formatMessage(defaultMessages.adminMessagesItem)}</span>
              }
            </span>
            {this.state.count_rooms > 0 &&
              <span className="indicator text-primary d-none d-lg-block">
                <i className="fa fa-fw fa-circle"></i>
              </span>
            }
          </Link>
          <div className="dropdown-menu messages" aria-labelledby="messagesDropdown">
            {this.state.listMessages}
            <div className="dropdown-divider"></div>
            <Link to="/admin/chat_rooms/0" className="dropdown-item small" href="#">{formatMessage(defaultMessages.adminMessagesShowAll)}</Link>
          </div>
        </li>
      </ul>
    );
  }
}

function Item(props){
  return (
    <div>
      <div className="dropdown-divider"></div>
      <Link to={"/admin/chat_rooms/"+props.room_id} className="dropdown-item" href="#">
        <strong>{props.name}</strong>
        <span className="small float-right text-muted">{props.time}</span>
        <div className="dropdown-message small">{props.message}</div>
      </Link>
    </div>
  )
}

export default injectIntl(MessageNotify)

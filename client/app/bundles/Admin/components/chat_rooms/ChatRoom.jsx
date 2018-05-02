import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';
import ReactOnRails from 'react-on-rails';

const csrfToken = ReactOnRails.authenticityToken();

export default class ChatRoom extends React.Component {
  constructor(props, _railsContext) {
    super(props);
  }

  render() {
    const {id, name, is_reply} = this.props;
    return (
      <li className={is_reply == false ? "unreply-room" : ""}>
        <Link to={`/admin/chat_rooms/${id}`}>
          <i className="fa fa-fw fa-user" />
          &nbsp;{name}&nbsp;
          {this.props.room_id == id ? <i className="fa fa-arrow-right" /> : ""}
        </Link>
      </li>
    );
  }
}

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
    const {message, is_supporter, created_at} = this.props;
    if(is_supporter === true){
      return (
        <div className="chat-message right">
          <div className="chat-avatar">
            <img className="chat-avatar-img" src="../../assets/supporter.png" alt=""></img>
          </div>
          <div className="chat-content">
            <div className="chat-content-inner">
              <p className="chat-text">{message}</p>
            </div>
          </div>
        </div>
      );
    } else {
      return (
        <div className="chat-message">
          <div className="chat-avatar">
            <img className="chat-avatar-img" src="../../assets/customer.png" alt=""></img>
          </div>
          <div className="chat-content">
            <div className="chat-content-inner">
              <p className="chat-text">{message}</p>
            </div>
          </div>
        </div>
      );
    }
  }
}

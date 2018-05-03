import React from 'react';
import ReactOnRails from 'react-on-rails';
import axios from 'axios';
import {Redirect} from 'react-router-dom';
import {FormattedMessage, injectIntl, intlShape} from 'react-intl';
import {defaultMessages} from '../../../../libs/i18n/default';
import Errors from '../Errors';
import {handleInputChange} from '../../utils/InputHandler';
import {Checkbox, CheckboxGroup} from 'react-checkbox-group';
import {ReactMde, ReactMdeCommands} from 'react-mde';
import 'react-mde/lib/styles/react-mde.css';
import 'react-mde/lib/styles/react-mde-command-styles.css';
import 'react-mde/lib/styles/markdown-default-theme.css';

const csrfToken = ReactOnRails.authenticityToken();

export default class MessageNew extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      message: "",
      is_supporter: true,
      chat_room_id: "",
    };
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
  }

  handleFormSubmit(e) {
    e.preventDefault();
    let formData = new FormData();
    formData.append("message", this.state.message);
    formData.append("is_supporter", this.state.is_supporter);
    formData.append("chat_room_id", this.props.id);
    axios.post(`/v1/messages.json`,
      formData,
      {
        headers: {'Authorization': this.props.authenticity_token},
        responseType: 'json'
      })
      .then((response) => {
        const {status, message, content} = response.data;
        if(status === 200) {
          this.setState({submitSuccess: true});
          this.setState({message: ""});
        } else {
          this.setState({errors: content});
          $.growl.error({message: message});
        }
      })
      .catch(error => {
        console.log(error);
      });
  }

  render() {
    const {formatMessage} = this.props.intl;
    return (
      <form role="form" onSubmit={this.handleFormSubmit} id="new-message-form">
        <div className="form-group">
          <input ref="message" name="message" type="text" className="form-control"
            value={this.state.message} onChange={handleInputChange.bind(this)}
            required="required"/>
          <button type="submit" className="btn btn-primary">
            {formatMessage(defaultMessages.adminMessagesSend)}
          </button>
        </div>
        <input type="hidden" ref="authenticity_token" value={csrfToken}/>
      </form>
    );
  }
}

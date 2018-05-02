import React from 'react';
import {FormattedMessage, injectIntl, intlShape} from 'react-intl';
import {defaultMessages} from '../../../libs/i18n/default';
import {Link} from 'react-router-dom';

class Sidebar extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const {formatMessage} = this.props.intl;
    return (
      <div className="collapse navbar-collapse navbar-ex1-collapse">
        <ul className="nav navbar-nav side-nav">
          <li>
            <Link to="/admin/courses">
              <i className="fa fa-fw fa-codepen" />
              &nbsp;{formatMessage(defaultMessages.adminSidebarCourses)}
            </Link>
          </li>
          <li>
            <Link to="/admin/registration_courses">
              <i className="fa fa-fw fa-registered" />
              &nbsp;{formatMessage(defaultMessages.adminSidebarRegistrationCourse)}
            </Link>
          </li>
          <li>
            <Link to="/admin/course_schedules">
              <i className="fa fa-fw fa-registered" />
              &nbsp;{formatMessage(defaultMessages.adminSidebarCourseSchedule)}
            </Link>
          </li>
          <li>
            <Link to="/admin/users">
              <i className="fa fa-fw fa-user" />
              &nbsp;{formatMessage(defaultMessages.adminSidebarUsers)}
            </Link>
          </li>
          <li>
            <Link to="/admin/newses">
              <i className="fa fa-fw fa-newspaper-o" />
              &nbsp;{formatMessage(defaultMessages.adminSidebarNewses)}
            </Link>
          </li>
          <li>
            <Link to="/admin/feedbacks">
              <i className="fa fa-fw fa-commenting-o"/>
              &nbsp;{formatMessage(defaultMessages.adminSidebarFeedbacks)}
            </Link>
          </li>
          <li>
            <Link to="/admin/temporary_registrations">
              <i className="fa fa-fw fa-commenting-o"/>
              &nbsp;{formatMessage(defaultMessages.adminSidebarTemporaryRegistration)}
            </Link>
          </li>
          <li>
            <Link to="/admin/chat_rooms/1?reload=true">
              <i className="fa fa-fw fa-commenting-o"/>
              &nbsp;{formatMessage(defaultMessages.adminSidebarChatRoom)}
            </Link>
          </li>
        </ul>
      </div>
    );
  }
}

export default injectIntl(Sidebar);

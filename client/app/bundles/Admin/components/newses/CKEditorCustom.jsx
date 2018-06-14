import React from 'react';
import CKEditor from "react-ckeditor-component";

export default class CKEditorCustom extends React.Component {
  render() {
    return(
      <CKEditor
        activeClass="p10"
        scriptUrl = "https://cdn.ckeditor.com/4.9.2/full/ckeditor.js"
        content={this.props.content}
        events={{
          "change": this.props.onChange
        }}
      />
    )
  }
}

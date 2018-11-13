import React from 'react';
import ReactDOM from 'react-dom';

class HelloMessage extends React.Component {
  render() {
    return <div>Hellos, {this.props.name}</div>;
  }
}

ReactDOM.render(<HelloMessage name="World" />, document.getElementById('root'));
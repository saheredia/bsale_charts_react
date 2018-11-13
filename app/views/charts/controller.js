import React from 'react';
import ReactDOM from 'react-dom';

class HelloMessageTwo extends React.Component {
  render() {
    return <div>Hella, {this.props.name}</div>;
  }
}

ReactDOM.render(<HelloMessage name="World" />, document.getElementById('root'));


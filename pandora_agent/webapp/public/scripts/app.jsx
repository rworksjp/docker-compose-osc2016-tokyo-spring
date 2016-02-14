var request = window.superagent;
var App = React.createClass({
  getInitialState: function () {
    return {title: "message", message: "Hello World"};
  },
  onClick: function () {
    var _this = this;
    request.get('/message')
    .end(function(err, res) {
      if (err || !res.ok) {
        console.err(err);
      }
      else {
        _this.setState(res.body);
      }
    });
  },
  render: function() {
    return (
      <main>
        <h1>{this.state.title}</h1>
        <p>{this.state.message}</p>
        <button type="button" onClick={ this.onClick }>next</button>
      </main>
    );
  }
});
ReactDOM.render(<App />, document.getElementById('content'));

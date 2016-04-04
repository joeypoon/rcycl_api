var UserLoginPage = React.createClass({

  getInitialState: function() {
    return(
      this._defaultState()
    )
  },

  _defaultState: function() {
    return(
      { email: '', password: '' }
    )
  },

  _handleSubmit: function(e) {
    e.preventDefault();
    this._postLogin()
  },

  _handleEmailChange: function(e) {
    this.setState({email: e.target.value});
  },

  _handlePasswordChange: function(e) {
    this.setState({password: e.target.value});
  },

  _userObject: function() {
    return(
      {
        user: {
          email: this.state.email,
          password: this.state.password
        }
      }
    )
  },

  _displayAlert: function(errors) {
    var htmlString = errors.message;
    $('#user-login-form-alert').html(htmlString);
    $('#user-login-form-alert').show();
  },

  _postLogin: function() {
    var parent = this;
    $.ajax({
      method: "POST",
      url: "/v1/users/login",
      dataType: 'json',
      data: this._userObject()
    })
      .done(function(response) {
        console.log(response);
        parent.props.updateAuthToken(response.user.auth_token);
      })
      .fail(function(response) {
        errors = JSON.parse(response.responseText);
        parent._displayAlert(errors);
      });
  },

  _updatePage: function(page) {
    this.props.updatePage(page);
  },

  render: function() {
    return(
      <div>
        <div className="col-md-6 col-md-offset-3">
          <div id="user-login-form-alert" className="alert alert-danger" style={{display: 'none'}}></div>
          <form onSubmit={this._handleSubmit}>
            <div className="form-group">
              <input type="email" className="form-control" placeholder="Email" onChange={this._handleEmailChange} />
            </div>
            <div className="form-group">
              <input type="password" className="form-control" placeholder="Password" onChange={this._handlePasswordChange} />
            </div>
            <button type="submit" className="btn btn-success form-control">Submit</button>
            <span>New user? <a href="#" onClick={this._updatePage.bind(this, 'userSignup')}>Signup</a></span>
          </form>
        </div>
      </div>
    )
  }
});

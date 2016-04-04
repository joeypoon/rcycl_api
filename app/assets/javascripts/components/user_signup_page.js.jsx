var UserSignupPage = React.createClass({

  getInitialState: function() {
    return(
      { name: '', email: '', password: '', passwordConfirmation: '' }
    )
  },

  componentDidUpdate: function() {
    this._checkPasswords();
  },

  _checkPasswords: function() {
    if (this.state.passwordConfirmation === this.state.password) {
      $('#user-password-confirmation').removeClass('has-error');
      $('#user-password-confirmation .help-block').hide();
    } else {
      $('#user-password-confirmation').addClass('has-error');
      $('#user-password-confirmation .help-block').show();
    };
  },

  _handleSubmit: function(e) {
    e.preventDefault();
    this._postUser()
  },

  _handleNameChange: function(e) {
    this.setState({name: e.target.value});
  },

  _handleEmailChange: function(e) {
    this.setState({email: e.target.value});
  },

  _handlePasswordChange: function(e) {
    this.setState({password: e.target.value});
  },

  _handlePasswordConfirmationChange: function(e) {
    this.setState({passwordConfirmation: e.target.value});
  },

  _userObject: function() {
    return(
      {
        user: {
          name: this.state.name,
          email: this.state.email,
          password: this.state.password,
          password_confirmation: this.state.passwordConfirmation
        }
      }
    )
  },

  _displayAlert: function(errors) {
    var htmlString = "";
    for (var errorType in errors) {
      htmlString += (errorType + "<ul>");
      for (var error in errors[errorType]) {
        htmlString += ("<li>" + errors[errorType][error] + "</li>");
      }
      htmlString += "</ul>";
    }
    $('#user-form-alert').html(htmlString);
    $('#user-form-alert').show();
  },

  _postUser: function() {
    var parent = this;
    $.ajax({
      method: "POST",
      url: "/v1/users",
      dataType: 'json',
      data: this._userObject()
    })
      .done(function(response) {
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
        <div className="col-md-6 col-md-offset-3" style={{marginRight: '20px'}}>
          <div id="user-form-alert" className="alert alert-danger" style={{display: 'none'}}></div>
          <form onSubmit={this._handleSubmit}>
            <div className="form-group">
              <input type="text" className="form-control" placeholder="Name" onChange={this._handleNameChange} />
            </div>
            <div className="form-group">
              <input type="email" className="form-control" placeholder="Email" onChange={this._handleEmailChange} />
            </div>
            <div className="form-group">
              <input type="password" className="form-control" placeholder="Password" onChange={this._handlePasswordChange} />
            </div>
            <div className="form-group" id="user-password-confirmation">
              <input type="password" className="form-control" placeholder="Password Confirmation" onChange={this._handlePasswordConfirmationChange} />
              <span className="help-block" style={{display: 'none'}}>Passwords do not match</span>
            </div>
            <button type="submit" className="btn btn-success form-control">Submit</button>
            <span>Already have an account? <a href="#" onClick={this._updatePage.bind(this, 'userLogin')}>Login</a></span>
          </form>
        </div>
      </div>
    )
  }
});

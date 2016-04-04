var Application = React.createClass({

  getInitialState: function() {
    return(
      {
        page: '',
        authToken: this._checkForAuthToken()
      }
    )
  },

  _checkForAuthToken: function() {
    if (window.localStorage) {
      return window.localStorage.authToken;
    } else {
      return '';
    }
  },

  _updateAuthToken: function(authToken) {
    window.localStorage.authToken = authToken;
    this.setState({ authToken: authToken });
  },

  _updatePage: function(page) {
    if (page === 'logout') {
      this._updateAuthToken('');
    }
    this.setState({ page: page });
  },

  _renderPage: function() {
    switch(this.state.page) {
    case 'userLogin':
      return <UserLoginPage updateAuthToken={this._updateAuthToken} updatePage={this._updatePage} />;
    case 'userSignup':
      return <UserSignupPage updateAuthToken={this._updateAuthToken} updatePage={this._updatePage} />;
    case 'addressPage':
      return <AddressPage authToken={this.state.authToken} updatePage={this._updatePage} />;
    default:
      return <UserLoginPage updateAuthToken={this._updateAuthToken} updatePage={this._updatePage} />;
    }
  },

  render: function() {
    return (
      <div>
        <NavBar updatePage={this._updatePage}
                updateAuthToken={this._updateAuthToken}
                authToken={this.state.authToken}>
        </NavBar>
        <div className="container">
          {this._renderPage()}
        </div>
      </div>
    )
  }
});

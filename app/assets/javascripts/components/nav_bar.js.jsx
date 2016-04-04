var NavBar = React.createClass({

  _updatePage: function(page) {
    this.props.updatePage(page);
  },

  _links: function() {
    if (this.props.authToken === '') {
      return (
        <div className="collapse navbar-collapse" id="top-navbar-1">
          <ul className="nav navbar-nav navbar-right">
            <li><a href="#" onClick={this._updatePage.bind(this, 'userLogin')}>Login</a></li>
          </ul>
        </div>
      )
    } else {
      return (
        <div className="collapse navbar-collapse" id="top-navbar-1">
          <ul className="nav navbar-nav navbar-right">
            <li><a href="#" onClick={this._updatePage.bind(this, 'address')}>Logout</a></li>
            <li><a href="#" onClick={this._updatePage.bind(this, 'logout')}>Logout</a></li>
          </ul>
        </div>
      )
    }
  },

  render: function() {
    return (
      <div className="margin-bottom">
        <nav className="navbar navbar-inverse" role="navigation" style={{borderRadius: '0'}}>
          <div className="container">
            <div className="navbar-header">
              <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#top-navbar-1">
                <span className="sr-only">Toggle navigation</span>
                <span className="icon-bar"></span>
                <span className="icon-bar"></span>
                <span className="icon-bar"></span>
              </button>
              <a className="navbar-brand" href="#" onClick={this._updatePage.bind(this, 'home')}>rcycl</a>
            </div>
            {this._links()}
          </div>
        </nav>
      </div>
    )
  }
});

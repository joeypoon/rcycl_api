var AddressPage = React.createClass({

  getInitialState: function() {
    return (
      {
        addresses: []
      }
    )
  },

  componentDidMount: function() {
    this._getAddresses()
  },

  componentDidUpdate: function() {
    if (this.state.addresses.length) {
      this._showAddressList()
    } else {
      this._showNewForm()
    }
  },

  _addAddress: function(address) {
    var addresses = this.state.addresses.concat(address)
    this.setState({
      addresses: addresses
    })
  },

  _updateAddresses: function(addresses) {
    this.setState({ addresses: addresses })
  },

  _getAddresses: function() {
    var parent = this;
    $.ajax({
      method: "GET",
      url: "/v1/addresses",
      dataType: 'json',
      headers: { 'x-auth-token': this.props.authToken },
    })
      .done(function(response) {
        parent._updateAddresses(response.addresses);
      })
      .fail(function(response) {
        //do something
      });
  },

  _showNewForm: function() {
    $('#show-new-address-button').hide();
    $('#address-list').hide();
    $('#new-address-form').show();
  },

  _showAddressList: function() {
    $('#new-address-form').hide();
    $('#show-new-address-button').show();
    $('#address-list').show();
  },

  _renderAddresses: function() {
    var parent = this;
    if (this.state.addresses.length) {
      return (
        this.state.addresses.map(function(address, index) {
          return (
            <EditAddressForm authToken={parent.props.authToken} address={address} key={address.id} />
          )
        })
      )
    } else {
      return <div>No addresses saved.</div>;
    }
  },

  render: function() {
    return (
      <div>
        <button id="show-new-address-button" className="btn btn-primary pull-right" onClick={this._showNewForm} style={{display: 'none'}}>
          <span className="glyphicon glyphicon-plus" aria-hidden="true"></span>
        </button>

        <div id="new-address-form" style={{display: 'none'}}>
          <AddressForm authToken={this.props.authToken} addAddress={this._addAddress} />
        </div>
        <div id="address-list" style={{display: 'none'}}>
          {this._renderAddresses()}
        </div>
      </div>
    )
  }

});

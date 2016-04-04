var AddressForm = React.createClass({
  getInitialState: function() {
    return(
      {
        street: '',
        unitNumber: '',
        city: '',
        state: '',
        zipCode: ''
      }
    )
  },

  _handleSubmit: function(e) {
    e.preventDefault();
    if (!this._anyErrors()) {
      this._postAddress();
    }
  },

  _anyErrors: function() {
    var errors = false;
    if (this.state.street === '') {
      errors = true;
      $('#address-form-street').addClass('has-error');
      $('#address-form-street .help-block').show()
    } else {
      $('#address-form-street').removeClass('has-error');
      $('#address-form-street .help-block').hide()
    }

    if (this.state.city === '') {
      errors = true;
      $('#address-form-city').addClass('has-error');
      $('#address-form-city .help-block').show()
    } else {
      $('#address-form-city').removeClass('has-error');
      $('#address-form-city .help-block').hide()
    }

    if (this.state.state === '') {
      errors = true;
      $('#address-form-state').addClass('has-error');
      $('#address-form-state .help-block').show()
    } else {
      $('#address-form-state').removeClass('has-error');
      $('#address-form-state .help-block').hide()
    }

    if (this.state.zipCode === '') {
      errors = true;
      $('#address-form-zip-code').addClass('has-error');
      $('#address-form-zip-code .help-block').show()
    } else {
      $('#address-form-zip-code').removeClass('has-error');
      $('#address-form-zip-code .help-block').hide()
    }

    return errors;
  },

  _handleStreetChange: function(e) {
    this.setState({street: e.target.value});
  },

  _handleUnitNumberChange: function(e) {
    this.setState({unitNumber: e.target.value});
  },

  _handleCityChange: function(e) {
    this.setState({city: e.target.value});
  },

  _handleStateChange: function(e) {
    this.setState({state: e.target.value});
  },

  _handleZipCodeChange: function(e) {
    this.setState({zipCode: e.target.value});
  },

  _addressObject: function() {
    return(
      {
        address: {
          street: this.state.street,
          unit_number: this.state.unitNumber,
          city: this.state.city,
          state: this.state.state,
          zip_code: this.state.zipCode
        }
      }
    )
  },

  _postAddress: function() {
    var parent = this;
    $.ajax({
      method: "POST",
      url: "/v1/addresses",
      dataType: 'json',
      headers: { 'x-auth-token': this.props.authToken },
      data: this._addressObject()
    })
      .done(function(response) {
        parent.props.addAddress(response.address)
        parent._clearInputs();
      })
      .fail(function(response) {
        //do something
      });
  },

  _clearInputs: function() {
    $('#address-form-street .form-control').val('');
    $('#address-form-unit-number .form-control').val('');
    $('#address-form-city .form-control').val('');
    $('#address-form-state .form-control').val('');
    $('#address-form-zip-code .form-control').val('');
  },

  render: function() {
    return(
      <div>
        <div className="col-md-6 col-md-offset-3">
          <form onSubmit={this._handleSubmit}>
            <div className="form-group" id='address-form-street'>
              <input type="text" className="form-control" placeholder="Street" onChange={this._handleStreetChange} />
              <span className="help-block" style={{display: 'none'}}>Cannot be blank</span>
            </div>
            <div className="form-group" id='address-form-unit-number'>
              <input type="text" className="form-control" placeholder="Unit Number" onChange={this._handleUnitNumberChange} />
            </div>
            <div className="form-group" id='address-form-city'>
              <input type="text" className="form-control" placeholder="City" onChange={this._handleCityChange} />
              <span className="help-block" style={{display: 'none'}}>Cannot be blank</span>
            </div>
            <div className="form-group" id='address-form-state'>
              <input type="text" className="form-control" placeholder="State" onChange={this._handleStateChange} />
              <span className="help-block" style={{display: 'none'}}>Cannot be blank</span>
            </div>
            <div className="form-group" id='address-form-zip-code'>
              <input type="text" className="form-control" placeholder="Zip Code" onChange={this._handleZipCodeChange} />
              <span className="help-block" style={{display: 'none'}}>Cannot be blank</span>
            </div>
            <button type="submit" className="btn btn-success form-control">Submit</button>
          </form>
        </div>
      </div>
    )
  }
});

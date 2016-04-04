var EditAddressForm = React.createClass({
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

  componentDidMount: function() {
    if (typeof(this.props.address) !== 'undefined') {
      this.setState({
        street: this.props.address.street,
        unitNumber: this.props.address.unit_number,
        city: this.props.address.city,
        state: this.props.address.state,
        zipCode: this.props.address.zip_code
      })

      $('#' + this._groupId('street') + ' .form-control').val(this.props.address.street);
      $('#' + this._groupId('unit-number') + ' .form-control').val(this.props.address.unit_number);
      $('#' + this._groupId('city') + ' .form-control').val(this.props.address.city);
      $('#' + this._groupId('state') + ' .form-control').val(this.props.address.state);
      $('#' + this._groupId('zip-code') + ' .form-control').val(this.props.address.zip_code);
    }
  },

  _handleSubmit: function(e) {
    e.preventDefault();
    if (!this._anyErrors()) {
      this._putAddress();
    }
  },

  _anyErrors: function() {
    var errors = false;
    if (this.state.street === '') {
      errors = true;
      $('#' + this._groupId('street')).addClass('has-error');
      $('#' + this._groupId('street') + ' .help-block').show()
    } else {
      $('#' + this._groupId('street')).removeClass('has-error');
      $('#' + this._groupId('street') + ' .help-block').hide()
    }

    if (this.state.city === '') {
      errors = true;
      $('#' + this._groupId('city')).addClass('has-error');
      $('#' + this._groupId('city') + ' .help-block').show()
    } else {
      $('#' + this._groupId('city')).removeClass('has-error');
      $('#' + this._groupId('city') + ' .help-block').hide()
    }

    if (this.state.state === '') {
      errors = true;
      $('#' + this._groupId('state')).addClass('has-error');
      $('#' + this._groupId('state') + ' .help-block').show()
    } else {
      $('#' + this._groupId('state')).removeClass('has-error');
      $('#' + this._groupId('state') + ' .help-block').hide()
    }

    if (this.state.zipCode === '') {
      errors = true;
      $('#' + this._groupId('zip-code')).addClass('has-error');
      $('#' + this._groupId('zip-code') + ' .help-block').show()
    } else {
      $('#' + this._groupId('zip-code')).removeClass('has-error');
      $('#' + this._groupId('zip-code') + ' .help-block').hide()
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

  _putAddress: function() {
    var parent = this;
    $.ajax({
      method: "PUT",
      url: "/v1/addresses/" + this.props.address.id,
      dataType: 'json',
      headers: { 'x-auth-token': this.props.authToken },
      data: this._addressObject()
    })
      .done(function(response) {
        //do stuff
      })
      .fail(function(response) {
        //do something
      });
  },

  _deleteAddress: function() {
    var parent = this;
    if (window.confirm('Delete this address?')) {
      $.ajax({
        method: "DELETE",
        url: "/v1/addresses/" + this.props.address.id,
        dataType: 'json',
        headers: { 'x-auth-token': this.props.authToken }
      })
        .done(function(response) {
          //remove from parent state
        })
        .fail(function(response) {
          //do something
        });
    }
  },

  _clearInputs: function() {
    $('#' + this._groupId('street') + ' .form-control').val('');
    $('#' + this._groupId('unit-number') + ' .form-control').val('');
    $('#' + this._groupId('city') + ' .form-control').val('');
    $('#' + this._groupId('state') + ' .form-control').val('');
    $('#' + this._groupId('zip-code') + ' .form-control').val('');
  },

  _groupId: function(type) {
    return (
      'address-edit-' + type + '-' + this.props.address.id
    )
  },

  render: function() {
    return(
      <div>
        <div className="col-md-6 col-md-offset-3">
          <form onSubmit={this._handleSubmit}>
            <div className="form-group" id={this._groupId('street')}>
              <input type="text" className="form-control" placeholder="Street" onChange={this._handleStreetChange} />
              <span className="help-block" style={{display: 'none'}}>Cannot be blank</span>
            </div>
            <div className="form-group" id={this._groupId('unit-number')}>
              <input type="text" className="form-control" placeholder="Unit Number" onChange={this._handleUnitNumberChange} />
            </div>
            <div className="form-group" id={this._groupId('city')}>
              <input type="text" className="form-control" placeholder="City" onChange={this._handleCityChange} />
              <span className="help-block" style={{display: 'none'}}>Cannot be blank</span>
            </div>
            <div className="form-group" id={this._groupId('state')}>
              <input type="text" className="form-control" placeholder="State" onChange={this._handleStateChange} />
              <span className="help-block" style={{display: 'none'}}>Cannot be blank</span>
            </div>
            <div className="form-group" id={this._groupId('zip-code')}>
              <input type="text" className="form-control" placeholder="Zip Code" onChange={this._handleZipCodeChange} />
              <span className="help-block" style={{display: 'none'}}>Cannot be blank</span>
            </div>
            <button type="submit" className="btn btn-success">
              <span className="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
            </button>
            <a className="btn btn-danger" onClick={this._deleteAddress} style={{marginLeft: '5px'}}>
              <span className="glyphicon glyphicon-trash" aria-hidden="true"></span>
            </a>
          </form>
        </div>
      </div>
    )
  }
});

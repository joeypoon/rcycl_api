class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :login]

  def new
    render component: 'UserSignupForm'
  end

  def show
  end

  def login
  end
end

class ApiController < ActionController::Base #ActionController::API
  protect_from_forgery with: :null_session
end

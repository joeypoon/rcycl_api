module AuthToken
  extend ActiveSupport::Concern

  def regenerate_auth_token
    token = generate_auth_token
    set_auth_token token
  end

  def auth_expired?
    Time.now >= self.auth_expiration
  end

  def generate_auth_token
    SecureRandom.base64(24)
  end

  def set_auth_token token
    self[:auth_token] = self.id.to_s + token
    self[:auth_expiration] = Time.now + 1.day
    save!
  end
end
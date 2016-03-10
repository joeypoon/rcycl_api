class Subscriber < ActiveRecord::Base
  validates :email, presence: true
  after_create :send_email

  private

    def send_email
      SubscriberMailer.welcome_email(self).deliver_now
    end
end
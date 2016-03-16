class SubscriberMailer < ApplicationMailer
  def welcome_email(subscriber)
    @subscriber = subscriber
    mail(to: @subscriber.email, subject: 'Welcome to rcycl!')
  end
end
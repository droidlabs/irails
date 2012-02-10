class SubscriptionMailer < ActionMailer::Base
  default from: configatron.noreply
  layout 'mailer'
  
  def payment_succeeded(subscription)
    @subscription = subscription
    @user = subscription.user
    mail(to: @user.email, subject: "Payment succeeded")
  end
  
  def payment_failed(subscription, attemp_count)
    @subscription = subscription
    @user = subscription.user
    mail(to: @user.email, subject: "Charge attempt failed!")
  end
  
  def account_blocked(subscription, attemp_count)
    @subscription = subscription
    @user = subscription.user
    mail(to: @user.email, subject: "Account blocked")
  end
  
  def trial_will_end(subscription)
    @subscription = subscription
    @user = subscription.user
    mail(to: @user.email, subject: "Trial period on #{configatron.app_name} expiring!")
  end
end

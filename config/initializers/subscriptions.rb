if configatron.subscription.enabled
  User.send(:include, User::Subscriptions)
end
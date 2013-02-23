class AdminUser 
  include Mongoid::Document
  include Mongoid::Timestamps
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
end

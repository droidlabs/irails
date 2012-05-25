class User < ActiveRecord::Base
  #include User::Subscriptions

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar,
    styles: {
      big: '256x256#',
      medium: '64x64#',
      small: '32x32#'
    }

  attr_accessible :email, :password, :password_confirmation, :full_name,
                  :about, :avatar

  validates :full_name, presence: true
end
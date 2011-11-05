class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar,
    styles: {
      big: '256x256#',
      medium: '64x64#',
      small: '32x32#'
    }

  validates :full_name, :presence => true
end

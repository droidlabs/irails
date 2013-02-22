class User
  include Mongoid::Document
  include Mongoid::Timestamps
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable


  # has_attached_file :avatar,
  #   styles: {
  #     big: '256x256#',
  #     medium: '64x64#',
  #     small: '32x32#'
  #   }

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type: Integer, :default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type: Time

  ## Token authenticatable
  # field :authentication_token, :type: String
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })

  field :full_name, type: String
  field :about,     type: String

  validates_presence_of :full_name
  attr_accessible :email, :password, :password_confirmation, :full_name,
                  :about 

end
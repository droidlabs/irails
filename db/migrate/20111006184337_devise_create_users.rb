class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable null: false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable

      t.string    :full_name
      t.text      :about

      t.string    :avatar_file_name
      t.string    :avatar_content_type
      t.integer   :avatar_file_size
      t.datetime  :avatar_updated_at

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end

  def self.down
    drop_table :users
  end
end

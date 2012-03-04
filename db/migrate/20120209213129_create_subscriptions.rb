class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer   :user_id
      t.string    :plan
      t.string    :customer_uid
      t.datetime  :blocked_at
      t.datetime  :trial_end_at
      t.timestamps
    end

    add_index :subscriptions, :user_id
  end
end

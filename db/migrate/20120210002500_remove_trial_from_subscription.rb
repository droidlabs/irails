class RemoveTrialFromSubscription < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :trial_end_at
  end

  def down
    add_column :subscriptions, :trial_end_at, :datetime
  end
end

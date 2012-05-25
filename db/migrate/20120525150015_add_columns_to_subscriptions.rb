class AddColumnsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :exp_year, :integer
    add_column :subscriptions, :exp_month, :integer
    add_column :subscriptions, :last_four_digits, :integer
    add_column :subscriptions, :cardholder_name, :string
    add_column :subscriptions, :card_type, :string
  end
end

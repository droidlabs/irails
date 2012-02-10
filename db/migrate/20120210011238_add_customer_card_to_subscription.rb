class AddCustomerCardToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :customer_card, :string
  end
end

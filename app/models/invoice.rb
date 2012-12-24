class Invoice < ActiveRecord::Base
  belongs_to :subscription
  serialize :stripe_attributes, Hash

  def amount_in_dollars
    (amount / 100).to_i
  end

  def stripe_charge
    @stripe_charge ||= Stripe::Charge.retrieve(charge_uid)
  end
end

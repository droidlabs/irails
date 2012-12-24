class Card
  include ActiveModel::Validations

  attr_accessor :full_name, :number, :card_type, :expires_at, :cvc, :plan, :to_key

  validates :full_name, :number, :expires_at, :plan, presence: true
  validate :expires_in_future

  def initialize(attributes = nil)
    return unless attributes
    @expires_at = Date.civil(
      attributes[:"expires_at(1i)"].to_i,
      attributes[:"expires_at(2i)"].to_i,
      attributes[:"expires_at(3i)"].to_i) rescue nil
    %w[number full_name plan cvc].each do |param|
      send("#{param}=", attributes[param])
    end
  end

  def stripe_attributes
    {
      name: full_name,
      cvc: cvc,
      number: number.gsub(/[^0-9]/, ''),
      exp_year: expires_at.year,
      exp_month: expires_at.month
    }
  end

  def persisted?
    false
  end

  private

  def expires_in_future
    errors.add(:expires_at, :invalid) if expires_at && expires_at < Date.today
  end
end

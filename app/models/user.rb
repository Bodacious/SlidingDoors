# == Schema Information
#
# id         :integer         not null
# first_name :string          not null
# last_name  :string          not null
# email      :string          not null
# shipping_address_line_1 :string
# shipping_address_line_2 :string
# shipping_address_postcode :string
# shipping_address_county :string
# shipping_address_country :string
# shipping_address_town :string
# billing_address_line_1 :string
# billing_address_line_2 :string
# billing_address_postcode :string
# billing_address_county :string
# billing_address_country :string
# billing_address_town :string
# created_at :datetime        not null
# updated_at :datetime        not null
# ==
class User < ApplicationRecord
  def best_correspondence_address
    if shipping_address_deliverable?
      [
        shipping_address_line_1,
        shipping_address_line_2,
        shipping_address_postcode,
        shipping_address_town,
        shipping_address_county,
        shipping_address_country
      ].select(&:present?).join("\n")
    elsif billing_address_deliverable?
      [
        billing_address_line_1,
        billing_address_line_2,
        billing_address_postcode,
        billing_address_town,
        billing_address_county,
        billing_address_country
      ].select(&:present?).join("\n")
    else
      nil
    end
  end

  private

  def shipping_address_deliverable?
    shipping_address_line_1? && shipping_address_postcode?
  end

  def billing_address_deliverable?
    billing_address_line_1? && billing_address_postcode?
  end
end

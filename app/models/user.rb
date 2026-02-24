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
end

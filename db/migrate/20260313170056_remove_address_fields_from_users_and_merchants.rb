class RemoveAddressFieldsFromUsersAndMerchants < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :shipping_address_line_1, :string
    remove_column :users, :shipping_address_line_2, :string
    remove_column :users, :shipping_address_postcode, :string
    remove_column :users, :shipping_address_town, :string
    remove_column :users, :shipping_address_county, :string
    remove_column :users, :shipping_address_country, :string
    remove_column :users, :billing_address_line_1, :string
    remove_column :users, :billing_address_line_2, :string
    remove_column :users, :billing_address_postcode, :string
    remove_column :users, :billing_address_town, :string
    remove_column :users, :billing_address_county, :string
    remove_column :users, :billing_address_country, :string

    remove_column :merchants, :shipping_address_line_1, :string
    remove_column :merchants, :shipping_address_line_2, :string
    remove_column :merchants, :shipping_address_postcode, :string
    remove_column :merchants, :shipping_address_town, :string
    remove_column :merchants, :shipping_address_county, :string
    remove_column :merchants, :shipping_address_country, :string
    remove_column :merchants, :billing_address_line_1, :string
    remove_column :merchants, :billing_address_line_2, :string
    remove_column :merchants, :billing_address_postcode, :string
    remove_column :merchants, :billing_address_town, :string
    remove_column :merchants, :billing_address_county, :string
    remove_column :merchants, :billing_address_country, :string
    remove_column :merchants, :registered_address_line_1, :string
    remove_column :merchants, :registered_address_line_2, :string
    remove_column :merchants, :registered_address_postcode, :string
    remove_column :merchants, :registered_address_town, :string
    remove_column :merchants, :registered_address_county, :string
    remove_column :merchants, :registered_address_country, :string
  end
end

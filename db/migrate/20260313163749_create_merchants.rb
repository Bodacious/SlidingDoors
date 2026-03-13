class CreateMerchants < ActiveRecord::Migration[8.0]
  def change
    create_table :merchants do |t|
      t.string :shipping_address_line_1
      t.string :shipping_address_line_2
      t.string :shipping_address_postcode
      t.string :shipping_address_town
      t.string :shipping_address_county
      t.string :shipping_address_country
      t.string :billing_address_line_1
      t.string :billing_address_line_2
      t.string :billing_address_postcode
      t.string :billing_address_town
      t.string :billing_address_county
      t.string :billing_address_country
      t.string :registered_address_line_1
      t.string :registered_address_line_2
      t.string :registered_address_postcode
      t.string :registered_address_town
      t.string :registered_address_county
      t.string :registered_address_country

      t.timestamps
    end
  end
end

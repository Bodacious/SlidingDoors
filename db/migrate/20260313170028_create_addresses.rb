class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :postcode
      t.string :town
      t.string :county
      t.string :country
      t.string :address_type
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :address, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.string :zipcode, null: false
      t.string :phone, null: false
      t.integer :addressable_id
      t.string  :addressable_type

      t.timestamps
    end

    add_index :addresses, [:addressable_type, :addressable_id]
  end
end

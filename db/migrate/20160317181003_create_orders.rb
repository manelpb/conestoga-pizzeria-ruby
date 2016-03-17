class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :delivery_address
      t.string :delivery_postalcode
      t.string :delivery_province
      t.string :delivery_city
      t.string :pizza_size
      t.string :pizza_toppings
      t.string :pizza_crust
      t.boolean :delivered

      t.timestamps null: false
    end
  end
end

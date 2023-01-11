class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.integer :order_action, null: false
      t.string :percent_change
      t.float :fund, null: false
      t.float :unit_price
      t.float :quantity

      t.timestamps
    end
  end
end

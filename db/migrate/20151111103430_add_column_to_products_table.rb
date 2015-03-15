class AddColumnToProductsTable < ActiveRecord::Migration
  def change
    add_column :products, :capacity, :float
  end
end
class AddColumnAgainToProductsTable < ActiveRecord::Migration
  def change
    add_column :products, :brand, :string
  end
end
class CreateProductsTable < ActiveRecord::Migration
  def change
    create_table :products do |col|
      col.string :name
      col.float :price
      col.float :rating
      col.string :model_number
      col.string :asin
      col.float :weight
      col.string :dimensions
      col.text :bullets
      col.text :description
      col.string :image_source

      col.timestamp
    end
  end
end

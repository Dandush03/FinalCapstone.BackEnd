# Generate Categories Migration
class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :category

      t.timestamps
    end
  end
end

# Generate Task Migration
class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.datetime :start
      t.datetime :end
      t.integer :seconds
      t.integer :minutes
      t.integer :hours

      t.references :category, references: :categories, foreign_key: { to_table: :categories }
      t.references :user, references: :users, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

# frozen_string_literal: true

# Generate User Migration
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end

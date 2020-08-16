# Generate Token Migration
class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :token, index: { unique: true }
      t.string :request_ip

      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end

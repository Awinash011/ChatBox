class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name,              null: false, default: ""
      t.datetime :created_at
    end
    add_index :users, :user_name,                unique: true
  end
end
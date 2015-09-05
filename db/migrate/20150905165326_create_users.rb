class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :encrypted_password

      t.timestamps null: false
    end
  end
end

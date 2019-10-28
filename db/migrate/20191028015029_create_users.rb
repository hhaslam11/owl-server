class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.text :avatar
      t.timestamp :join_date
      t.timestamp :last_login
    end
  end
end

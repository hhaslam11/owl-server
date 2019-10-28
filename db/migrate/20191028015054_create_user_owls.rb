class CreateUserOwls < ActiveRecord::Migration[5.1]
  def change
    create_table :user_owls do |t|
      t.references :user, foreign_key: true
      t.references :owl, foreign_key: true
    end
  end
end

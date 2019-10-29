class CreateOwls < ActiveRecord::Migration[5.1]
  def change
    create_table :owls do |t|
      t.string :name
      t.integer :speed
      t.integer :carrying_capacity
      t.text :image

      t.timestamps
    end
  end
end

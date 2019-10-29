class CreateSeals < ActiveRecord::Migration[5.1]
  def change
    create_table :seals do |t|
      t.references :country, foreign_key: true
      t.string :title
      t.text :image

      t.timestamps
    end
  end
end

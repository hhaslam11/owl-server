class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :abbreviation
      t.integer :timezone
      t.decimal :lat, precision: 9, scale: 6
      t.decimal :lon, precision: 9, scale: 6
      t.text :flag_image
    end
  end
end

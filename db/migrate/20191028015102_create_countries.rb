class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :abbreviation
      t.integer :timezone
      t.text :flag_image
    end
  end
end

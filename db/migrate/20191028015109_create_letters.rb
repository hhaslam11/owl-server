class CreateLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :letters do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :from_country, foreign_key: { to_table: :countries }
      t.references :to_country, foreign_key: { to_table: :countries }
      t.references :user_owl, foreign_key: true, null: false, default: -> { 1 }
      t.references :receiver, foreign_key: { to_table: :users }
      t.text :content
      t.timestamp :sent_date, null: false, default: -> { 'NOW()' }
      t.timestamp :delivery_date
      t.timestamp :pick_up_date
    end
  end
end

class CreateJoinTableLanguageCountry < ActiveRecord::Migration[5.1]
  def change
    create_join_table :languages, :countries do |t|
      # t.index [:language_id, :country_id]
      # t.index [:country_id, :language_id]
    end
  end
end

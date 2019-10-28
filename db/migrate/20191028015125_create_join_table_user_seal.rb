class CreateJoinTableUserSeal < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :seals do |t|
      # t.index [:user_id, :seal_id]
      # t.index [:seal_id, :user_id]
    end
  end
end

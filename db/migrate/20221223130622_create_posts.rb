class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.timestamps
      t.integer :end_user_id, null: false
      t.string :body, null: false
    end
  end
end

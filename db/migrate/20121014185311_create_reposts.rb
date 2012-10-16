class CreateReposts < ActiveRecord::Migration
  def change
    create_table :reposts do |t|
      t.string :content
      t.integer :user_id
      t.integer :micropost_id
      t.string :micropost_id
      t.string :created_at

      t.timestamps
    end
    add_index :reposts, :micropost_id
    add_index :reposts, :created_at
  end
end

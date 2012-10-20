class CreateRetweetings < ActiveRecord::Migration
  def change
    create_table :retweetings do |t|
      t.integer :retweeter_id
      t.integer :retweet_id

      t.timestamps
    end
    add_index :retweetings, :retweeter_id
    add_index :retweetings, :retweet_id
    add_index :retweetings, [:retweeter_id, :retweet_id], unique: true
  end
end

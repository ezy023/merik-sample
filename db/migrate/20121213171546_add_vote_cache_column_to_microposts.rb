class AddVoteCacheColumnToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :cached_votes_total, :integer
    add_column :microposts, :cached_votes_up, :integer
    add_column :microposts, :cached_votes_down, :integer
    add_index :microposts, :cached_votes_total
    add_index :microposts, :cached_votes_up
    add_index :microposts, :cached_votes_down
  end
end

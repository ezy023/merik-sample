class AddVoteCacheColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :cached_votes_total, :integer
    add_column :comments, :cached_votes_up, :integer
    add_column :comments, :cached_votes_down, :integer
    add_index :comments, :cached_votes_total
    add_index :comments, :cached_votes_up
    add_index :comments, :cached_votes_down
  end
end

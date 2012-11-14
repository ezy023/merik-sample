class AddPostIdToTestimony < ActiveRecord::Migration
  def change
    add_column :testimonies, :post_id, :integer
  end
end

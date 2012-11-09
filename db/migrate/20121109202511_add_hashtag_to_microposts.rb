class AddHashtagToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :hashtag, :string
  end
end

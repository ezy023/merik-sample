class AddProfileColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_auth, :string
    add_column :users, :soundcloud_auth, :string
  end
end

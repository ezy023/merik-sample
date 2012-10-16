class AddColumnToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :artist, :string
    add_column :microposts, :genre, :string
  end
end

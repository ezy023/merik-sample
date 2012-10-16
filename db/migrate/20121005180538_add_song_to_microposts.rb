class AddSongToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :song, :string
  end
end

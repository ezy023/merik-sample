class AddSongDescriptionToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :song_description, :string, :default => "(Click to enter song description)"
  end
end

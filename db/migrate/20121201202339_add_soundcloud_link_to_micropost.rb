class AddSoundcloudLinkToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :sc_link, :string
  end
end

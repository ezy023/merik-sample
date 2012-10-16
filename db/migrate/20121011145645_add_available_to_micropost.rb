class AddAvailableToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :available, :boolean, default: false
  end
end

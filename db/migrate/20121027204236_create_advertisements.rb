class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|

      t.timestamps
    end
  end
end

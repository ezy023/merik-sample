class CreateAdvertises < ActiveRecord::Migration
  def change
    create_table :advertises do |t|

      t.timestamps
    end
  end
end

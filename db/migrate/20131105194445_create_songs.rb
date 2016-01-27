class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :length
      t.string :genre

      t.timestamps
    end
  end
end

class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :filename_url
      t.integer :user_id
      t.timestamps
    end
  end
end

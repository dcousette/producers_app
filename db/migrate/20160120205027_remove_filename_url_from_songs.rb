class RemoveFilenameUrlFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :filename_url
  end
end

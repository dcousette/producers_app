class Song < ActiveRecord::Base
  mount_uploader :song_file, SongFileUploader
  validates_presence_of :name
  validates_uniqueness_of :name
end

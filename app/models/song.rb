class Song < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name
  validates_uniqueness_of :name
  mount_uploader :song_file, SongFileUploader
end

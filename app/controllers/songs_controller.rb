class SongsController < ApplicationController
  before_action :require_sign_in, only: [:new, :create]
  def new
    @user = User.find(current_user.id)
    @song = Song.new
  end

  def create
    user = User.find(params[:user_id])
    song = user.songs.build(name: params[:song][:name], song_file: params[:song][:song_file])
    song.save
    redirect_to current_user
  end
end

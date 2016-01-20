class SongsController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @song = Song.new 
  end
end

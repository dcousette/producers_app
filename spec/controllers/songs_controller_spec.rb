require 'rails_helper'

describe SongsController do
  describe 'GET new' do
    let(:joe) { Fabricate(:user) }

    it_behaves_like 'require sign in' do
      let(:action) { get :new, user_id: joe.id }
    end

    it 'places the current user in @user' do
      set_up_user(joe)
      get :new, user_id: joe.id
      expect(assigns(:user)).to eq(joe)
    end

    it 'sets up @song' do
      set_up_user(joe)
      get :new, user_id: joe.id
      expect(assigns(:song)).to be_present
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      it 'saves a song to the database'
      it 'redirects to the user profile page'
    end

    context 'with invalid input' do

    end
  end
end

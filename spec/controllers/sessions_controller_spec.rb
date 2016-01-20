require 'rails_helper'

describe SessionsController do
  let(:joe) { Fabricate(:user) }

  describe "POST #create" do
    before { session[:user_id] = nil }

    context "with valid credentials" do
      it "sets a user in the session" do
        post :create, username: joe.username, password: joe.password
        expect(session[:user_id]).to eq(joe.id)
      end

      it "sets the flash succcess message" do
        post :create, username: joe.username, password: joe.password
        expect(flash[:success]).to be_present
      end

      it "redirects to the user show page" do
        post :create, username: joe.username, password: joe.password
        expect(response).to redirect_to user_path(joe)
      end
    end

    context "with invalid credentials" do
      it "does not set a user in the session" do
        post :create, username: "fakejoe", password: "hackjob"
        expect(session[:user_id]).to eq(nil)
      end

      it "redirects to the sign in page" do
        post :create, username: "fakejoe", password: "hackjob"
        expect(response).to redirect_to signin_path
      end

      it "sets the flash error message" do
        post :create, username: "fakejoe", password: "hackjob"
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before { session[:user_id] = joe.id }

    it "removes the signed in user from the session" do
      delete :destroy, id: joe.id
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects to the sign in page" do
      delete :destroy, id: joe.id
      expect(response).to redirect_to signin_path
    end

    it "sets the flash success message" do
      delete :destroy, id: joe.id
      expect(flash[:success]).to be_present
    end
  end
end

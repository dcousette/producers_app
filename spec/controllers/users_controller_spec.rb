require 'rails_helper'

describe UsersController do
  describe "GET #index" do
    it_behaves_like "require sign in" do
      let(:action) { get :index }
    end

    it "sets an array of all users to @users" do
      alice = Fabricate(:user)
      joe = Fabricate(:user)
      set_up_user(alice)
      get :index
      expect(assigns(:users)).to eq([alice, joe])
    end
  end

  describe "GET #new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST #create" do
    context "with valid input" do
      it "creates a user in the database" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it "sets the flash success message" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[:success]).to be_present
      end

      it "redirects to the user show path" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to users_path
      end
    end

    context "with invalid input" do
      it "renders the new user template" do
        post :create, user: { username: "Joe Smith" }
        expect(response).to redirect_to new_user_path 
      end

      it "does not add a user to the database" do
        post :create, user: { username: "Joe Smith" }
        expect(User.count).to eq(0)
      end

      it "sets the flash error message" do
        post :create, user: { username: "Joe Smith" }
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "GET #edit" do
    let(:joe) { Fabricate(:user) }

    it_behaves_like "require sign in" do
      let(:action) { get :edit, id: joe.id }
    end

    it "sets up the @user" do
      set_up_user(joe)
      get :edit, id: joe.id
      expect(assigns(:user).id).to eq(joe.id)
    end

    it "redirects unauthorized users to the users page" do
      set_up_user(joe)
      jane = Fabricate(:user)
      get :edit, id: jane.id
      expect(response).to redirect_to users_path
    end
  end

  describe "PUT #update" do
    let(:joe) { Fabricate(:user, username: "Joe Smith", password: 'joesmith') }

    it_behaves_like "require sign in" do
      let(:action) { put :update, id: joe.id, user: { username: "Bad Bill Cosby", email: "drinkup@gmail.com", password: 'joesmith' } }
    end

    before { set_up_user(joe) }

    context "with valid input" do
      it "retrieves and sets up user" do
        put :update, id: joe.id, user: { username: "Bad Bill Cosby", email: "drinkup@gmail.com", password: 'joesmith' }
        expect(User.first).to eq(joe)
      end

      it "updates an attribute of the user" do
        put :update, id: joe.id, user: { username: "Bad Bill Cosby", email: "drinkup@gmail.com", password: 'joesmith' }
        expect(User.first.username).to eq("Bad Bill Cosby")
      end

      it "redirects to the the user path" do
        put :update, id: joe.id, user: { username: "Bad Bill Cosby", email: "drinkup@gmail.com", password: 'joesmith' }
        expect(response).to redirect_to user_path(joe.id)
      end

      it "sets the flash success message" do
        put :update, id: joe.id, user: { username: "Bad Bill Cosby", email: "drinkup@gmail.com", password: 'joesmith' }
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      it "does not update data for the user" do
        put :update, id: joe.id, user: { username: "", email: "drinkup@gmail.com" }
        expect(User.first.username).to eq("Joe Smith")
      end

      it "renders the edit user template" do
        put :update, id: joe.id, user: { username: "", email: "drinkup@gmail.com" }
        expect(response).to redirect_to edit_user_path(joe)
      end

      it "sets the flash error message" do
        put :update, id: joe.id, user: { username: "", email: "drinkup@gmail.com" }
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    let(:joe) { Fabricate(:user) }

    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: joe.id }
    end

    before { set_up_user(joe) }

    it "removes the user from the database" do
      delete :destroy, id: joe.id
      expect(User.count).to eq(0)
    end

    it "redirects to the users index path" do
      delete :destroy, id: joe.id
      expect(response).to redirect_to users_path
    end

    it "sets the flash success message" do
      delete :destroy, id: joe.id
      expect(flash[:success]).to be_present
    end
  end
end

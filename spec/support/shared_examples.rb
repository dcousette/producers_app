shared_examples "require sign in" do
  before { session[:user_id] = nil }

  it "redirects the unauthenticated user to the sign in page" do
    action
    expect(response).to redirect_to signin_path
  end
end

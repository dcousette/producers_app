def set_up_user(user= nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

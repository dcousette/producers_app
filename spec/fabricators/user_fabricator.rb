Fabricator(:user) do
  username { Faker::Internet.user_name }
  email { Faker::Internet.safe_email }
  password { Faker::Internet.password(16,16) }
end

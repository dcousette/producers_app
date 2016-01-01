Fabricator(:user) do
  username { Faker::Internet.user_name }
  email { Faker::Internet.safe_email }
end

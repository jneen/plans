Builders.build Account do
  login { Faker::Internet.user_name }
  password { Faker::Internet.password }
end

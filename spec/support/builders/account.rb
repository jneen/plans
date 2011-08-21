Builders.build Account do
  login { Faker::Internet.user_name.gsub(/\W/,'_') }
  password { Faker::Internet.password }
end

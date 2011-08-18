Builders.build Plan do
  contents { Faker::Lorem.paragraphs(10) }
  account { build Account }
end

Builders.build Plan do
  contents { Faker::Lorem.paragraphs(10).join("\n\n") }
  account { build Account }
end

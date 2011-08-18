module Faker
  def Internet.password(min_chars=6)
    length = min_chars + rand(10)
    ''.ljust(length, Lorem.word)
  end
end

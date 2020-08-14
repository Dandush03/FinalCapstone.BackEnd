FactoryBot.define do
  factory :task do
    name { Faker::Lorem.word }
    description { Faker::Lorem.word }
    start { Time.now }
    category_id { 1 }
    user_id { 1 }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { Faker::Lorem.word }
    description { Faker::Lorem.word }
    start { Date.today }
    category_id { 1 }
    user_id { 1 }
  end
end

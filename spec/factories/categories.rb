# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:category) { |n| "category#{n}" }
  end
end

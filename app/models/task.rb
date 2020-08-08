# frozen_string_literal: true

# Task Model
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 255 }
end

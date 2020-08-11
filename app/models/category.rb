# Category Model
class Category < ApplicationRecord
  has_many :tasks

  validates_presence_of :category
end

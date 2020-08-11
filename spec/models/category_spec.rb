require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:tasks) }
  it { should validate_presence_of(:category) }
end

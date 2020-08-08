# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(30) }
  it { should validate_length_of(:description).is_at_most(255) }
end

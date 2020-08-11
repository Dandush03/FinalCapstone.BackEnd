# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tasks) }
  it { should validate_presence_of(:full_name) }
  it { should validate_length_of(:full_name).is_at_most(50) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:username).is_at_most(30) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(15) }
end

class Token < ApplicationRecord
  belongs_to :user, -> { order('created_at desc') },
             foreign_key: 'user_id',
             required: true

  validates :token, presence: true, uniqueness: true
  validates :request_ip, presence: true
end

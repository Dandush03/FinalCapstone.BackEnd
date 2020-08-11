# frozen_string_literal: true

# Task Model
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  before_save :task_create
  before_update :task_close  

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 255 }

  protected

  def task_create
    self.start = Time.now if start.nil?
  end

  def task_close
    return if start.nil? || self.end.nil?

    total = self.end - start
    self.minutes = (total / 60).floor % 60
    self.seconds = total.to_i % 60
    self.hours = ((total / 60).floor / 60)
  end
end

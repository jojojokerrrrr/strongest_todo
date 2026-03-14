class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: {maximum: 50}
  validates :category, presence: true
  validates :description, length: {maximum: 500}, allow_blank: true

  enum :status, { incomplete: 0, completed: 1 }
end

class Lesson < ApplicationRecord
  has_many :reservations

  validates :name,
    presence: { message: 'は必須項目です' }
  validates :content,
    presence: { message: 'は必須項目です' }
end

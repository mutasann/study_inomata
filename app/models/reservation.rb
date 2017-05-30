class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  # include ActiveModel::Model
  #
  # attr_accessor :date_time

  validates :date_time,
    presence: { message: 'は必須項目です' },
    date_time: true
end

class ErrorLog < ApplicationRecord
  belongs_to :import, counter_cache: true

  has_one :user, through: :import

  validates :row, presence: true,
                  numericality: { only_integer: true }
  validates :message, presence: true
end

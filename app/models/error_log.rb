class ErrorLog < ApplicationRecord
  belongs_to :import

  validates :row, presence: true,
                  numericality: { only_integer: true }
  validates :message, presence: true
end

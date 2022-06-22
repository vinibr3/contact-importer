class Import < ApplicationRecord
  belongs_to :user

  has_many :contacts

  enum status: { on_hold: 0, processing: 1, failed: 2, terminated: 3 }

  has_one_attached :contacts_file

  validate :contacts_file_attached
  validate :contacts_file_as_csv

  private

  def contacts_file_attached
    errors.add(:contacts_file, :blank) unless contacts_file.try(:attached?)
  end

  def contacts_file_as_csv
    errors.add(:contacts_file, :invalid) unless contacts_file.try(:content_type) == 'text/csv'
  end
end

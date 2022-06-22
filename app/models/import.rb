class Import < ApplicationRecord
  HEADERS = %i[name date_of_birth_iso8601 telephone address credit_card email]

  belongs_to :user

  has_many :contacts
  has_many :error_logs

  enum status: { on_hold: 0, processing: 1, failed: 2, terminated: 3 }

  has_one_attached :contacts_file

  serialize :headers, Array

  validate :contacts_file_attached
  validate :contacts_file_as_csv

  def headers=(value)
    self[:headers] = value.to_s.split(',')
  end

  private

  def contacts_file_attached
    errors.add(:contacts_file, :blank) unless contacts_file.try(:attached?)
  end

  def contacts_file_as_csv
    errors.add(:contacts_file, :invalid) unless contacts_file.try(:content_type) == 'text/csv'
  end
end

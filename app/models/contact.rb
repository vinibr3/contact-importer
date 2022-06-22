# frozen_string_literal: true

class Contact < ApplicationRecord
  CREDIT_CARD_NUMBERS_COUNT_TO_SAVE = 4.freeze

  belongs_to :import

  has_one :user, through: :import

  attr_accessor :credit_card
  attr_accessor :date_of_birth_iso8601

  validates :name, presence: true,
                   format: { with: NAMES_REGEX }
  validates :address, presence: true
  validates :credit_card, presence: true,
                          on: :create
  validates :credit_card, numericality: { only_integer: true }
  validates :credit_card_digest, presence: true
  validates :last_credit_card_numbers, presence: true
  validates :franchise, presence: true
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    length: { maximum: 255 }
  validates :telephone, presence: true,
                        format: { with: TELEPHONE_REGEX }
  validates :date_of_birth, presence: true

  before_validation :assign_last_credit_card_numbers, if: proc {|c| c.credit_card.present? }
  before_validation :encrypts_credit_card, if: proc {|c| c.credit_card.present? }
  before_validation :changes_email_to_downcase
  before_validation :assign_date_of_birth, if: proc {|c| c.date_of_birth_iso8601.present? }

  validate :uniqueness_of_email_scoped_by_contact_user
  validate :date_of_birth_iso8601_format

  def franchise
    return self[:franchise] if credit_card.blank?

    self.franchise = CREDIT_CARDS_REGEX.detect {|k, v| v.match?(credit_card) }
                                       .try(:first)
  end

  private

  def assign_last_credit_card_numbers
    self.last_credit_card_numbers = credit_card.last(CREDIT_CARD_NUMBERS_COUNT_TO_SAVE)
  end

  def encrypts_credit_card
    self.credit_card_digest = Digest::SHA512.hexdigest(credit_card)
  end

  def uniqueness_of_email_scoped_by_contact_user
    errors.add(:email, :taken) if user && user.contacts.exists?(email: email)
  end

  def changes_email_to_downcase
    self.email = self.email.to_s.downcase
  end

  def assign_date_of_birth
    self.date_of_birth = parse_date_of_birth_iso8601_to_date
  end

  def parse_date_of_birth_iso8601_to_date
    return unless date_of_birth_iso8601.to_s.match?(DATE_ISO8601_REGEXP)

    Date.parse(date_of_birth_iso8601)
  rescue Date::Error
    nil
  end

  def date_of_birth_iso8601_format
    birthday = parse_date_of_birth_iso8601_to_date

    errors.add(:date_of_birth, :invalid) and return if birthday.blank?
  end
end

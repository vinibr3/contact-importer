require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { build(:contact) }

  it 'has a valid factory' do
    expect(contact).to be_valid
  end

  it { is_expected.to(validate_presence_of(:address)) }
  it { is_expected.to(validate_presence_of(:credit_card).on(:create)) }
  it { is_expected.to(validate_numericality_of(:credit_card)) }
  it { is_expected.to(validate_presence_of(:credit_card_digest)) }
  it { is_expected.to(validate_presence_of(:last_credit_card_numbers)) }
  it { is_expected.to(validate_presence_of(:franchise)) }
  it { is_expected.to(validate_presence_of(:email)) }
  it { is_expected.to(validate_length_of(:email).is_at_most(255)) }
  it { is_expected.to(have_one(:user).through(:import)) }
  it { is_expected.to(validate_presence_of(:name)) }

  context 'when credit_card american express' do
    let(:contact) { build(:contact, :with_credit_card_american_express) }

    it 'franchise is american express' do
      expect(contact.franchise).to eq('american express')
    end
  end

  context 'when credit_card visa' do
    let(:contact) { build(:contact, :with_credit_card_visa) }

    it 'franchise is visa' do
      expect(contact.franchise).to eq('visa')
    end
  end

  context 'when credit_card jcb' do
    let(:contact) { build(:contact, :with_credit_card_jcb) }

    it 'franchise is jcb' do
      expect(contact.franchise).to eq('jcb')
    end
  end

  context 'when credit_card discover' do
    let(:contact) { build(:contact, :with_credit_card_discover) }

    it 'franchise is discover' do
      expect(contact.franchise).to eq('discover')
    end
  end

  context 'when run before validation callback' do
    let(:email) { Faker::Internet.email }
    let(:contact) { create(:contact, email: email.upcase) }

    it 'changes email to downcase' do
      expect(contact.email).to eq(email.downcase)
    end
  end

  context 'when validates email' do
    describe 'with valid email' do
      it 'contact is valid' do
        expect(contact).to be_valid
      end
    end

    describe 'with invalid email' do
      let(:contact) { build(:contact, email: '@sdd.com') }

      it 'contact is invalid' do
        expect(contact).to be_invalid
      end
    end
  end

  context 'when validates email scoped to user' do
    describe 'with duplicated contact email per same user' do
      let(:contact) { create(:contact) }
      let(:user) { contact.user }

      it 'contact is invalid' do
        new_contact = build(:contact, user: contact.user, email: contact.email)

        expect(new_contact).to be_invalid
      end
    end

    describe 'with duplicated contact email per different users' do
      let(:contact) { create(:contact) }
      let(:user) { contact.user }

      it 'contact is valid' do
        new_contact = build(:contact, email: contact.email)

        expect(new_contact).to be_valid
      end
    end
  end

  context 'when validates telephone' do
    describe 'with valid number white spaced' do
      let(:contact) { build(:contact, :with_valid_number_white_spaced) }

      it 'contact is valid' do
        expect(contact).to be_valid
      end
    end

    describe 'with valid number minus spaced' do
      let(:contact) { build(:contact, :with_valid_number_minus_spaced) }

      it 'contact is valid' do
        expect(contact).to be_valid
      end
    end

    describe 'with invalid telephone' do
      let(:contact) { build(:contact, telephone: Faker::PhoneNumber.cell_phone_with_country_code) }

      it 'contact is invalid' do
        expect(contact).to be_invalid
      end
    end
  end

  context 'when validates date of birth' do
    describe 'with valid format' do
      let(:contact) { build(:contact, :with_valid_date_of_birth_iso8601) }

      it 'contact is valid' do
        expect(contact).to be_valid
      end
    end

    describe 'with invalid format' do
      let(:contact) { build(:contact, date_of_birth_iso8601: '') }

      it 'contact is invalid' do
        expect(contact).to be_invalid
      end
    end

    describe 'with nonexistent date' do
      let(:contact) { build(:contact, :with_nonexistent_birth_of_date) }

      it 'contact is invalid' do
        expect(contact).to be_invalid
      end
    end
  end
end

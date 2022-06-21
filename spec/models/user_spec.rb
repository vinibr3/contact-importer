require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it { is_expected.to(validate_presence_of(:email)) }
  it { is_expected.to(validate_uniqueness_of(:email).case_insensitive) }
  it { is_expected.to(validate_length_of(:email).is_at_most(255)) }
  it { is_expected.to(have_db_index(:email)) }
  it { is_expected.to(have_secure_password) }
  it { is_expected.to(validate_length_of(:password).is_at_most(255)) }
  it { is_expected.to(validate_length_of(:password).is_at_least(8)) }

  context 'when save' do
    let(:email) { Faker::Internet.email }
    let(:user) { create(:user, email: email.upcase) }

    it 'changes email to downcase' do
      expect(user.email).to eq(email.downcase)
    end
  end

  context 'when validates email' do
    describe 'with valid email' do
      it 'user is valid' do
        expect(user).to be_valid
      end
    end

    describe 'with invalid email' do
      let(:user) { build(:user, email: '@sdd.com') }

      it 'user is invalid' do
        expect(user).to be_invalid
      end
    end
  end
end

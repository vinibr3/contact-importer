require 'rails_helper'

RSpec.describe ErrorLog, type: :model do
  let(:error_log) { build(:error_log) }

  it 'has a valid factory' do
    expect(error_log).to be_valid
  end

  it { is_expected.to(validate_presence_of(:row)) }
  it { is_expected.to(validate_presence_of(:message)) }
  it { is_expected.to(validate_numericality_of(:row).only_integer) }
  it { is_expected.to(belong_to(:import)) }
  it { is_expected.to(have_one(:user).through(:import)) }
end

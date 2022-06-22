require 'rails_helper'

RSpec.describe Import, type: :model do
  let(:import) { build(:import) }

  it 'has a valid factory' do
    expect(import).to be_valid
  end

  it { is_expected.to(belong_to(:user)) }
  it { is_expected.to(have_db_index(:status)) }
  it { is_expected.to(define_enum_for(:status).with_values(%i[on_hold processing failed terminated])) }
  it { is_expected.to(serialize(:headers)) }

  context 'when validate' do
    describe 'with file attached' do
      it 'import is invalid' do
        expect(import).to be_valid
      end
    end

    describe 'with contacts file no attached' do
      let(:import) { build(:import, contacts_file: nil) }

      it 'import is invalid' do
        expect(import).to be_invalid
      end
    end

    describe 'with csv contacts file' do
      it 'import is invalid' do
        expect(import).to be_valid
      end
    end

    describe 'with not csv contacts file' do
      let(:import) { build(:import, :with_png_contacts_file) }

      it 'import is invalid' do
        expect(import).to be_invalid
      end
    end
  end
end

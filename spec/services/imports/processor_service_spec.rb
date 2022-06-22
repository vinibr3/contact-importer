require 'rails_helper'

RSpec.describe Imports::ProcessorService, type: :service do
  context 'when process valid contacts' do
    let(:import) { create(:import) }

    subject { Imports::ProcessorService.call(import: import) }

    it 'creates contacts for user' do
      expect{ subject }.to change{ import.user.contacts.count }.by(1)
    end

    it 'final status is terminated' do
      expect(subject.terminated?).to be_truthy
    end

    it 'does not create error_logs' do
      expect{ subject }.to change{ import.error_logs.count }.by(0)
    end
  end

  context 'when process invalid contacts' do
    let(:import) { create(:import, :with_invalid_contact) }

    subject { Imports::ProcessorService.call(import: import) }

    it 'does not create contacts for user' do
      expect{ subject }.to change{ import.user.contacts.count }.by(0)
    end

    it 'final status is failed' do
      expect(subject.failed?).to be_truthy
    end

    it 'creates error_logs' do
      expect{ subject }.to change{ import.error_logs.count }.by(1)
    end

    describe 'with empty file' do
      let(:import) { create(:import, :with_empty_contact) }

      subject { Imports::ProcessorService.call(import: import) }

      it 'does not create contacts for user' do
        expect{ subject }.to change{ import.user.contacts.count }.by(0)
      end

      it 'final status is terminated' do
        expect(subject.terminated?).to be_truthy
      end

      it 'does not create error_logs' do
        expect{ subject }.to change{ import.error_logs.count }.by(0)
      end
    end
  end
end

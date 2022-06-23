require 'rails_helper'

RSpec.describe ImportsController, type: :controller do
  let(:contacts_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/contacts.csv'), 'text/csv') }
  before { Authentication.with_user(@request) }

  context 'GET new' do
    before { get :new, params: { locale: :en } }

    it { is_expected.to(route(:get, '/en/imports/new').to(action: :new, locale: :en)) }
    it { is_expected.to(respond_with(:ok)) }
    it { is_expected.to(render_template(:new)) }
  end

  context 'POST create' do
    it { is_expected.to(route(:post, '/en/imports').to(action: :create, locale: :en)) }

    describe 'when valid params' do
      let(:params) { { import: { headers: Import::HEADERS.join(','),
                                 contacts_file: contacts_file },
                       locale: :en } }

      before { post :create, params: params }

      it { is_expected.to(redirect_to(imports_path)) }
      it { is_expected.to(respond_with(:found)) }
      it do
        is_expected.to(permit(:headers, :contacts_file)
                       .for(:create, params: params)
                       .on(:import))
      end
    end

    describe 'when invalid params' do
      before { post :create, params: { import: { headers: '',
                                                 contacts_file: contacts_file },
                                        locale: :en } }

      it { is_expected.to(render_template(:new)) }
      it { is_expected.to(respond_with(:unprocessable_entity)) }
    end
  end
end

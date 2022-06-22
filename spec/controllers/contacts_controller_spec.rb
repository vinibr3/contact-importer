require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  context 'GET index' do
    before { Authentication.with_user(@request) }
    before { get :index, params: { locale: :en } }

    it { is_expected.to(route(:get, '/en/contacts').to(action: :index, locale: :en)) }
    it { is_expected.to(respond_with(:ok)) }
    it { is_expected.to(render_template(:index)) }
  end
end

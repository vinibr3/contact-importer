require 'rails_helper'

RSpec.describe ErrorLogsController, type: :controller do
  context 'GET index' do
    let(:error_log) { create(:error_log) }
    let(:import_id) { error_log.import.id }

    before { Authentication.with_user(error_log.user, @request) }
    before { get :index, params: { locale: :en, import_id: import_id } }

    it { is_expected.to(route(:get, "/en/imports/#{import_id}/error_logs")
                        .to(action: :index, locale: :en, import_id: import_id)) }
    it { is_expected.to(respond_with(:ok)) }
    it { is_expected.to(render_template(:index)) }
  end
end

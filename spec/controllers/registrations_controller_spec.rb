require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  context 'GET new' do
    before { get :new, params: { locale: :en } }

    it { is_expected.to(route(:get, '/en/registrations/new').to(action: :new, locale: :en)) }
    it { is_expected.to(respond_with(:ok)) }
    it { is_expected.to(render_template(:new)) }
  end

  context 'POST create' do
    it { is_expected.to(route(:post, '/en/registrations').to(action: :create, locale: :en)) }

    describe 'when valid params' do
      let(:email) { Faker::Internet.email }
      let(:password) { Faker::Internet.password }
      let(:params) { { user: { email: email,
                                               password: password,
                                               password_confirmation: password },
                                        locale: :en } }

      before { post :create, params: params }

      it { is_expected.to(redirect_to(new_import_path)) }
      it { is_expected.to(respond_with(:found)) }
      it do
        is_expected.to(permit(:email, :password, :password_confirmation)
                       .for(:create, params: params)
                       .on(:user))
      end
    end

    describe 'when invalid params' do
      before { post :create, params: { user: { email: '',
                                               password: '',
                                               password_confirmation: '' },
                                        locale: :en } }

      it { is_expected.to(render_template(:new)) }
      it { is_expected.to(respond_with(:unprocessable_entity)) }
    end
  end
end

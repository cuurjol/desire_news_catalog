require 'rails_helper'

RSpec.describe User, type: :request do
  let!(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'with valid attributes' do
      before(:each) { get(users_path) }
      it { expect(response).to have_http_status(200) }
      it { expect(response).to match_response_schema('users') }
    end
  end
end

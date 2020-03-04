require 'rails_helper'

RSpec.describe NewsItem, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:published_news_item) { FactoryBot.create(:news_item) }
  let!(:unpublished_news_item) { FactoryBot.create(:news_item, :unpublished) }

  describe 'GET #index' do
    context 'with valid attributes' do
      before(:each) { get(user_news_items_path(user)) }
      it { expect(response).to have_http_status(200) }
      it { expect(response).to match_response_schema('news_items') }
    end

    context 'with invalid attributes' do
      before(:each) { get(user_news_items_path(0)) }
      it { expect(response).to have_http_status(404) }
    end
  end
end

require 'rails_helper'

RSpec.describe NewsItem, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:published_news_item) { FactoryBot.create(:news_item) }
  let!(:unpublished_news_item) { FactoryBot.create(:news_item, :unpublished) }

  describe 'GET #index' do
    context 'with valid attributes' do
      before(:each) { get(news_items_path) }
      it { expect(response).to have_http_status(200) }
      it { expect(response).to match_response_schema('news_items') }
    end
  end

  describe 'GET #show' do
    context 'with valid attributes' do
      before(:each) { get(news_item_path(published_news_item)) }
      it { expect(response).to have_http_status(200) }
      it { expect(response).to match_response_schema('news_item') }
    end

    context 'unpublished news_item with auth owner user' do
      before(:each) do
        sign_in(unpublished_news_item.user)
        get(news_item_path(unpublished_news_item))
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response).to match_response_schema('news_item') }
    end

    context 'unpublished news_item with auth another user' do
      before(:each) do
        sign_in(user)
        get(news_item_path(unpublished_news_item))
      end

      it { expect(response).to have_http_status(404) }
    end

    context 'unpublished news_item without auth user' do
      before(:each) { get(news_item_path(unpublished_news_item)) }
      it { expect(response).to have_http_status(404) }
    end
  end

  describe 'POST #create' do
    let(:params) do
      { news_item: { title: 'Hello world', preview: 'This is my world',
                     description: 'It is beautiful', status: 'published' } }
    end

    context 'with valid attributes' do
      before(:each) do
        sign_in(user)
        post(news_items_path(params))
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response).to match_response_schema('action_news_item') }
    end

    context 'with invalid attributes' do
      before(:each) do
        sign_in(user)
        post(news_items_path(news_item: { title: '' }))
      end

      it { expect(response).to have_http_status(422) }
    end

    context 'without auth user' do
      before(:each) { post(news_items_path(params)) }
      it { expect(response).to have_http_status(401) }
    end
  end

  describe 'PUT #update' do
    let(:params) do
      { news_item: { title: 'Hello world', preview: 'This is my world',
                     description: 'It is beautiful', status: 'published' } }
    end

    context 'with valid attributes' do
      before(:each) do
        sign_in(unpublished_news_item.user)
        put(news_item_path(unpublished_news_item, params))
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response).to match_response_schema('action_news_item') }
    end

    context 'with invalid attributes' do
      before(:each) do
        sign_in(unpublished_news_item.user)
        put(news_item_path(unpublished_news_item, news_item: { title: '' }))
      end

      it { expect(response).to have_http_status(422) }
    end

    context 'with invalid auth user' do
      before(:each) do
        sign_in(user)
        put(news_item_path(unpublished_news_item, params))
      end

      it { expect(response).to have_http_status(404) }
    end

    context 'without auth user' do
      before(:each) { put(news_item_path(unpublished_news_item, params)) }
      it { expect(response).to have_http_status(401) }
    end
  end

  describe 'DELETE #destroy' do
    context 'with auth user' do
      before(:each) do
        sign_in(published_news_item.user)
        delete(news_item_path(published_news_item))
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'with invalid auth user' do
      before(:each) do
        sign_in(user)
        delete(news_item_path(published_news_item))
      end

      it { expect(response).to have_http_status(404) }
    end

    context 'without auth user' do
      before(:each) { delete(news_item_path(published_news_item)) }
      it { expect(response).to have_http_status(401) }
    end
  end

  describe 'PUT #add_to_favorites' do
    context 'with owner auth user' do
      before(:each) do
        sign_in(published_news_item.user)
        post(add_to_favorites_news_item_path(published_news_item))
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'with another auth user' do
      before(:each) do
        sign_in(user)
        post(add_to_favorites_news_item_path(published_news_item))
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'without auth user' do
      before(:each) { post(add_to_favorites_news_item_path(published_news_item)) }
      it { expect(response).to have_http_status(401) }
    end
  end

  describe 'GET #unread' do
    context 'with auth user' do
      before(:each) do
        sign_in(user)
        get(unread_news_items_path)
      end

      it { expect(response).to have_http_status(200) }
      it { expect(response).to match_response_schema('news_items') }
    end

    context 'without auth user' do
      before(:each) { get(unread_news_items_path) }
      it { expect(response).to have_http_status(401) }
    end
  end
end

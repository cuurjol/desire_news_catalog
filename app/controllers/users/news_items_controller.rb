module Users
  class NewsItemsController < ApplicationController
    def index
      user = User.find(params[:user_id])
      @news_items = current_user == user ? user.news_items : user.news_items.published
      render(json: { message: 'List of NewsItems.', news_items: @news_items.as_json(only: %i[id title preview]) })
    end
  end
end

class NewsItemsController < ApplicationController
  before_action :authenticate!, except: %i[index show]

  def index
    @news_items = NewsItem.published
    render(json: { message: 'List of NewsItems.', news_items: @news_items.as_json(only: %i[id title preview]) })
  end

  def show
    @news_item = find_news_item

    if @news_item.published? || current_user&.news_items&.include?(@news_item)
      if current_user && !current_user.read_news_items.include?(@news_item)
        CatalogNewsItem.find_or_initialize_by(user: current_user, news_item: @news_item).update(read: true)
      end

      render(json: @news_item)
    else
      error_string = "Couldn't find NewsItem with 'id'=#{@news_item.id}"
      raise(ActiveRecord::RecordNotFound, error_string)
    end
  end

  def create
    @news_item = NewsItem.new(news_item_params.merge(user: current_user))
    @news_item.save!
    render(json: { message: 'NewsItem was created.', news_item: @news_item })
  end

  def update
    @news_item = find_user_news_item
    @news_item.update!(news_item_params)
    render(json: { message: 'NewsItem was updated.', news_item: @news_item })
  end

  def destroy
    render(json: { message: 'NewsItem was destroyed.', news_item: find_user_news_item.destroy! })
  end

  def add_to_favorites
    @news_item = find_news_item

    if @news_item.published?
      CatalogNewsItem.find_or_initialize_by(user: current_user, news_item: @news_item).update!(favorite: true)
      render(json: { message: 'NewsItem was added to favorites.', news_item: @news_item })
    else
      error_string = "Couldn't find NewsItem with 'id'=#{@news_item.id}"
      raise(ActiveRecord::RecordNotFound, error_string)
    end
  end

  def unread
    @news_items = current_user.unread_news_items
    render(json: { message: 'List of unread NewsItems.', news_items: @news_items.as_json(only: %i[id title preview]) })
  end

  private

  def find_news_item
    NewsItem.find(params[:id])
  end

  def find_user_news_item
    current_user.news_items.find(params[:id])
  end

  def news_item_params
    params.require(:news_item).permit(:title, :preview, :description, :status)
  end
end

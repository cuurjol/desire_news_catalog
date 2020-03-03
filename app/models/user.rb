class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  has_many :news_items, dependent: :destroy
  has_many :catalog_news_items, dependent: :destroy
  has_many :read_news_items, -> { where(catalog_news_items: { read: true }) },
           through: :catalog_news_items, source: :news_item

  validates :login, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :full_name, presence: true, length: { minimum: 10, maximum: 50 }
  validates :signature, allow_blank: true, length: { maximum: 25 }

  def unread_news_items
    NewsItem.where.not(id: read_news_item_ids).published
  end
end

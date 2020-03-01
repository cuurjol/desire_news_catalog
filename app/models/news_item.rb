class NewsItem < ApplicationRecord
  belongs_to :user
  has_many :catalog_news_items, dependent: :destroy

  enum status: { unpublished: 0, published: 1 }

  validates :title, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :preview, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 10_000 }
end

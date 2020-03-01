class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  has_many :news_items, dependent: :destroy
  has_many :catalog_news_items, dependent: :destroy

  validates :login, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :full_name, presence: true, length: { minimum: 10, maximum: 50 }
  validates :signature, allow_blank: true, length: { maximum: 25 }
end

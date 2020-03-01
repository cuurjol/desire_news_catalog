class CreateCatalogNewsItems < ActiveRecord::Migration[5.2]
  def change
    create_table :catalog_news_items do |t|
      t.references :user, foreign_key: true
      t.references :news_item, foreign_key: true
      t.boolean :favorite, null: false, default: false
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end

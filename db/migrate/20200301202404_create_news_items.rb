class CreateNewsItems < ActiveRecord::Migration[5.2]
  def change
    create_table :news_items do |t|
      t.string :title, null: false
      t.string :preview, null: false
      t.text :description, null: false
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

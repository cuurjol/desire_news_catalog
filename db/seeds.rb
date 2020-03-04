5.times { FactoryBot.create(:user) }
10.times { FactoryBot.create(:news_item, :unpublished, user: User.all.sample) }
20.times { FactoryBot.create(:news_item, user: User.all.sample) }

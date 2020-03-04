FactoryBot.define do
  factory :news_item do
    association :user

    sequence(:title) { |n| "#{Faker::Lorem.word} #{n}" }
    preview { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    status { :published }
  end

  trait :unpublished do
    status { :unpublished }
  end
end

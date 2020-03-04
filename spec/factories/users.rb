FactoryBot.define do
  factory :user do
    login { Faker::Internet.safe_email }
    password { 'qwerty' }
    full_name { Faker::Name.last_name + ' ' + Faker::Name.first_name + ' ' + Faker::Name.middle_name }
    signature { Faker::Lorem.characters(number: 10) }
  end
end

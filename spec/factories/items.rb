FactoryBot.define do
  factory :item do
    name                   { Faker::Name.initials(number: 2) }
    info                   { 'wwwwwww' }
    price                  { 1000 }
    category_id            { 2 }
    status_id              { 2 }
    shipping_fee_status_id { 2 }
    scheduled_delivery_id  { 2 }
    prefecture_id          { 2 }

    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/furima-intro01.png'), filename: 'test_image.png')
    end
  end
end

FactoryBot.define do
  factory :order_address do
    token { 'aaabbbccc' }
    postal_code { '111-1111' }
    prefecture_id { 2 }
    city { 'tomakomai' }
    address { '3-4-5' }
    building { 'building3' }
    phone_number { '05011112222' }
  end
end

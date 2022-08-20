FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1k1k1k' }
    password_confirmation { password }
    first_name            { '太郎' }
    last_name             { '山田' }
    first_name_reading    { 'タロウ' }
    last_name_reading     { 'ヤマダ' }
    birthday              { '1999-10-10' }
  end
end
